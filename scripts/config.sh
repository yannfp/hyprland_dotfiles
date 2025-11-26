rplc_ln="\e[1A\e[K"
echo

# Essentials
echo -e "${rplc_ln}Installing essentials"
nix profile install nixpkgs#helix
# Shell
echo -e "${rplc_ln}Installing cli utilities"
nix profile install nixpkgs#zsh nixpkgs#fzf nixpkgs#zoxide nixpkgs#eza
# Desktop
echo -e "${rplc_ln}Installing desktop"
nix profile install nixpkgs#hyprland nixpkgs#rofi-wayland nixpkgs#hyprlock nixpkgs#waybar nixpkgs#xwayland nixpkgs#kitty nixpkgs#hyprpaper
echo -e "${rplc_ln}Installing desktop utilities"
nix profile install nixpkgs#swaynotificationcenter nixpkgs#nerd-fonts.jetbrains-mono nixpkgs#nerd-fonts.dejavu-sans-mono
nix profile install nixpkgs#grim nixpkgs#slurp nixpkgs#wl-clipboard

# Instant dotfiles
echo -e "${rplc_ln}Copying dotfiles"
instant_list="zshrc p10k.zsh local/share/zinit local/share/rofi"
mkdir -p "$HOME/.local/share"
for f in $instant_list; do
    rm -rf "$HOME/.$f"
    cp -r "$AFS_DIR/.confs/$f" "$HOME/.$f"
done


echo e "${rplc_ln}Start ?"
read
hyprland
