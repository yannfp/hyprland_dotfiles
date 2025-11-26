# .confs
cp -r ./.config/*        ~/afs/.confs/config
cp -r ./.local/*         ~/afs/.confs/local
cp -r ./.p10k.zsh        ~/afs/.confs/p10k.zsh
cp -r ./.zshrc           ~/afs/.confs/zshrc
cp -r ./afs-install.sh   ~/afs/.confs/install.sh

# install.sh (launched at session startup)
cp -r ./scripts/afs-install.sh   ~/afs/.confs/install.sh

# boussole.sh (launched by the user)
cp -r ./scripts/config.sh   ~/afs/config.sh

echo Done
