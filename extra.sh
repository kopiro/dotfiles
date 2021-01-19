#!/bin/bash

if [ ! -f ~/.iterm2_shell_integration.zsh ]
then
    if [[ "$OSTYPE" == "darwin"* ]]
    then
    echo "Installing iTerm shell integration"
    curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
    fi
fi

echo "Linking configurations"
find ./home -type f -exec sh -c 'f=$(basename "$1"); ln -svf ~/.dotfiles/home/$f ~/$f' _ {} \;
ln -svf ~/.bash_profile ~/.bashrc
touch ~/.bash_profile_custom