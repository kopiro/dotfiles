#!/bin/bash

[ ! -L ~/.drive ] && [ -d ~/Google\ Drive ] && ln -svf ~/Google\ Drive ~/.drive
[ ! -L ~/.icloud ] && [ -d ~/Library/Mobile\ Documents/com~apple~CloudDocs ] && ln -svf ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/.icloud

echo "Linking configurations"
find ~/.dotfiles/home -type f -exec sh -c 'f=$(basename "$1"); ln -svf ~/.dotfiles/home/$f ~/$f' _ {} \;