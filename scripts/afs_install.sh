#!/bin/sh

rplc_ln="\e[1A\e[K"
echo

# Dotfiles (default)
echo -e "${rplc_ln}Linking dotfiles"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/.cache"
dot_list="bashrc config emacs gitconfig gitignore jnewsrc mozilla msmtprc muttrc signature slrnrc ssh thunderbird vim vimrc Xdefaults clang-format bash_profile local/bin local/share/icons"
for f in $dot_list; do
  rm -rf "$HOME/.$f"
  ln -s "$AFS_DIR/.confs/$f" "$HOME/.$f"
done


# Instant dotfiles
# echo -e "${rplc_ln}Copying dotfiles"
# instant_list="zshrc p10k.zsh local/share/zinit local/share/rofi"
# mkdir -p "$HOME/.local/share"
# for f in $instant_list; do
#     rm -rf "$HOME/.$f"
#     cp -r "$AFS_DIR/.confs/$f" "$HOME/.$f"
# done


# Documents
echo -e "${rplc_ln}Linking documents"
doc_list="Pictures Workplan"
for f in $doc_list; do
  rm -rf "$HOME/$f"
  ln -s "$AFS_DIR/$f" "$HOME/$f"
done

echo -e "Config: done !"
