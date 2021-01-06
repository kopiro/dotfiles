#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
echo "Installing iTerm shell integration"
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
fi

echo "Linking configurations"
ln -svf ~/.dotfiles/conf/zshrc.sh ~/.zshrc
ln -svf ~/.dotfiles/conf/bash_profile.sh ~/.bash_profile
touch ~/.bash_profile_custom

echo "Installing OH-MY-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing Antigen"
if [[ "$OSTYPE" == "darwin"* ]]; then
brew install antigen
elif [[ "$OSTYPE" == "linux"* ]]; then
sudo apt-get install zsh-antigen
fi


