#!/bin/bash

# --- CONFIGURATION ---

# 1. REPLACE WITH YOUR DOTFILES REPOSITORY URL
DOTFILES_REPO="https://github.com/yannfp/hyprland_dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# 2. PACKAGE LISTS (Arch/AUR)
# Official Arch Repository Packages (System/Core/GUI)
PAC_PKGS=(
    # Core DE/Window Manager
    hyprland hyprpaper hyprlock
    # Core Utilities
    git vim zsh thunar
    # Shell/Utilities
    gcc clang ctags cscope
    # Audio/Brightness
    playerctl brightnessctl alsa-utils pipewire-alsa
    # Desktop Utilities
    grim slurp waybar rofi
    # Theming
    papirus-icon-theme
)

# Arch User Repository (AUR) Packages (Modern Tools/Replacements)
# Note: These require 'paru' and build from source.
AUR_PKGS=(
    starship eza bat ugrep fastfetch
    # Additional themes/tools (Qogir is often AUR)
    qogir-dark-theme-git envycontrol
)

# --- HELPER FUNCTIONS ---

function check_sudo() {
    if ! command -v sudo &> /dev/null; then
        echo "Error: 'sudo' command not found. Please install it."
        exit 1
    fi
}

function install_paru() {
    if ! command -v paru &> /dev/null; then
        echo "--> Installing AUR helper: paru"
        sudo pacman -S --needed base-devel git --noconfirm
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        (cd /tmp/paru && makepkg -si --noconfirm)
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install paru. Exiting."
            exit 1
        fi
    fi
}

function install_packages() {
    echo "--> Updating system and installing official packages..."
    sudo pacman -Syu --needed --noconfirm "${PAC_PKGS[@]}"

    echo "--> Installing AUR packages (this may take a while)..."
    paru -S --needed --noconfirm "${AUR_PKGS[@]}"
}

function setup_dotfiles() {
    echo "--> Cloning dotfiles into $DOTFILES_DIR..."
    # Clone the repo. Assuming the repo contains all configs in a structure
    # like .bashrc, .config/hypr, etc.
    if [ ! -d "$DOTFILES_DIR" ]; then
        git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi

    # The dotfiles reference ~/dotfiles/.config/... in config files,
    # so we'll clone it as a "bare" repo and check out the files manually.
    if [ -d "$DOTFILES_DIR" ]; then
        # Create a checkout directory for the dotfiles content
        DOTFILES_CONTENT_DIR="$DOTFILES_DIR-content"
        mkdir -p "$DOTFILES_CONTENT_DIR"
        
        # Clone it properly this time (or copy the contents if already cloned bare)
        git clone "$DOTFILES_REPO" "$DOTFILES_CONTENT_DIR"

        # Define the source (s) and destination (d) directory for links/copies
        S="$DOTFILES_CONTENT_DIR"
        D="$HOME"

        echo "--> Setting up configuration symlinks and copying files..."
        
        # Ensure all parent directories for configs exist
        mkdir -p "$D/.config/hypr/scripts"
        mkdir -p "$D/.config/hypr/themes"
        mkdir -p "$D/.config/kitty"
        mkdir -p "$D/.config/waybar"
        mkdir -p "$D/.config/fastfetch"
        mkdir -p "$D/.vim/plugged" # Needed for vim-plug install

        # Create Symlinks for main configs and the full dotfiles directory
        ln -sf "$S/.bashrc" "$D/.bashrc"
        ln -sf "$S/.vimrc" "$D/.vimrc"
        ln -sf "$S/.gitignore" "$D/.gitignore"
        ln -sf "$S/.vim" "$D/.vim"
        ln -sf "$S/.config/hypr/hyprland.conf" "$D/.config/hypr/hyprland.conf"
        ln -sf "$S/.config/hypr/hyprlock.conf" "$D/.config/hypr/hyprlock.conf"
        ln -sf "$S/.config/hypr/hyprpaper.conf" "$D/.config/hypr/hyprpaper.conf"
        ln -sf "$S/.config/hypr/scripts/launcher.sh" "$D/.config/hypr/scripts/launcher.sh"
        ln -sf "$S/.config/hypr/scripts/powermenu.sh" "$D/.config/hypr/scripts/powermenu.sh"
        ln -sf "$S/.config/hypr/themes/colors.rasi" "$D/.config/hypr/themes/colors.rasi"
        ln -sf "$S/.config/hypr/themes/launcher.rasi" "$D/.config/hypr/themes/launcher.rasi"
        ln -sf "$S/.config/hypr/themes/powermenu.rasi" "$D/.config/hypr/themes/powermenu.rasi"
        ln -sf "$S/.config/kitty/kitty.conf" "$D/.config/kitty/kitty.conf"
        ln -sf "$S/.config/kitty/current-theme.conf" "$D/.config/kitty/current-theme.conf"
        ln -sf "$S/.config/waybar/config" "$D/.config/waybar/config"
        ln -sf "$S/.config/waybar/style.css" "$D/.config/waybar/style.css"
        ln -sf "$S/.config/fastfetch/config.jsonc" "$D/.config/fastfetch/config.jsonc"
        
        # Set scripts executable
        chmod +x "$D/.config/hypr/scripts/launcher.sh"
        chmod +x "$D/.config/hypr/scripts/powermenu.sh"
        
        # The files use '~/dotfiles/' as the path for modular configs, 
        # so ensure the content is linked/available at '~/dotfiles'
        # Since 'dotfiles' directory is already created, the dotfiles' content 
        # should be available from this directory so the config can work.
        # The paths in the .vimrc explicitly use ~/dotfiles: 
        # source ~/dotfiles/.vim/config/settings.vim
        # We will link the cloned content directory to '~/dotfiles' (overwriting if necessary)
        # to ensure pathing is correct for scripts and VIM config.
        if [ -d "$DOTFILES_CONTENT_DIR" ]; then
            rm -rf "$DOTFILES_DIR" # Remove the initial bare clone directory
            ln -sf "$DOTFILES_CONTENT_DIR" "$DOTFILES_DIR"
        fi
        
    else
        echo "Error: Dotfiles directory was not created. Skipping symlinks."
    fi
}

function setup_vim_and_fonts() {
    echo "--> Setting up Vim plugins and fetching vim-plug..."
    # Install Vim-Plug
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Install the Nerd Font for TTY compatibility before starting Hyprland
    echo "--> Installing JetBrains Mono Nerd Font for TTY/Hyprland login screen..."
    # This is often installed via AUR, but here is a manual step just in case.
    TEMP_FONT_DIR="/tmp/fonts"
    mkdir -p "$TEMP_FONT_DIR"
    curl -fLo "$TEMP_FONT_DIR/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip "$TEMP_FONT_DIR/JetBrainsMono.zip" -d "$TEMP_FONT_DIR/JetBrainsMono"
    sudo cp "$TEMP_FONT_DIR/JetBrainsMono/"* /usr/share/fonts/
    fc-cache -fv
    rm -rf "$TEMP_FONT_DIR"
}


function final_steps() {
    echo "--> Setting permissions and initial setup..."

    # Set up GTK/Icon themes outside of Hyprland for initial login
    # Qogir-Dark and Papirus-Dark are specified in hyprland.conf
    gsettings set org.gnome.desktop.interface gtk-theme "Qogir-Dark"
    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
    gsettings set org.gnome.desktop.interface cursor-theme "Qogir-Dark"
    
    # Note on Shell (Zsh)
    echo ""
    echo "========================================================="
    echo "!!! ZSH IS RECOMMENDED !!!"
    echo "The README suggests Zsh, but a .bashrc file is provided."
    echo "If you wish to switch to Zsh, run:"
    echo "chsh -s /usr/bin/zsh"
    echo "========================================================="
    echo ""

    # Note on Vim plugins
    echo "========================================================="
    echo "!!! VIM PLUGIN INSTALLATION REQUIRED !!!"
    echo "Please launch Vim for the first time by running:"
    echo "vim"
    echo "Then run the command to install all plugins:"
    echo ":PlugInstall"
    echo "========================================================="
    echo ""

    # Final instruction
    echo "Installation and configuration setup complete!"
    echo "Reboot the system and select Hyprland from your display manager (if installed) or run 'Hyprland' from the TTY to start the desktop session."
}

# --- MAIN EXECUTION ---
check_sudo
install_paru
install_packages
setup_dotfiles
setup_vim_and_fonts
final_steps

# Clear the screen after execution for a clean TTY
clear
