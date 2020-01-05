#!/bin/bash
set -x

ln -sf $(pwd)/conf/bash_profile.sh ~/.bash_profile
ln -sf $(pwd)/conf/eslintrc.json ~/.eslintrc.json
ln -sf $(pwd)/conf/editorconfig.txt ~/.editorconfig
ln -sf $(pwd)/conf/gitignore_global.txt ~/.gitignore_global

cp -f $(pwd)/conf/zshrc.txt ~/.zshrc
rm -rf ~/.oh-my-zsh/custom/plugins ~/.oh-my-zsh/custom/themes
ln -sf $(pwd)/oh-my-zsh/* ~/.oh-my-zsh/custom/

chmod +x $(pwd)/bin/*
