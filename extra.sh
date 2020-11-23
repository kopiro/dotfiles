#!/bin/bash

echo "Configuring structure"
mkdir -p ~/Projects
mkdir -p ~/Personal

echo "Installing iTerm shell integration"
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

echo "Linking configurations"
ln -svf ~/.dotfiles/conf/zshrc.sh ~/.zshrc
ln -svf ~/.dotfiles/conf/bash_profile.sh ~/.bash_profile
ln -svf ~/.dotfiles/conf/gitignore_global.txt ~/.gitignore_global
touch ~/.bash_profile_custom

echo "Installing OH-MY-ZSH"
brew install antigen
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
