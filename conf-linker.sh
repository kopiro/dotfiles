#!/bin/bash
set -ex
ln -sf /opt/dotfiles/conf/bash_profile.sh ~/.bash_profile
ln -sf /opt/dotfiles/conf/eslintrc.json ~/.eslintrc.json
ln -sf /opt/dotfiles/conf/editorconfig.txt ~/.editorconfig
ln -sf /opt/dotfiles/oh-my-zsh/* ~/.oh-my-zsh/custom/