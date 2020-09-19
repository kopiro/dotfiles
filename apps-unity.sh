#!/bin/bash

echo "Configuring structure"
mkdir -p ~/Projects
mkdir -p ~/Personal

echo "Linking configurations"
ln -sf ~/.dotfiles/conf/zshrc.sh ~/.zshrc
ln -sf ~/.dotfiles/conf/bash_profile.sh ~/.bash_profile
ln -sf ~/.dotfiles/conf/gitignore_global.txt ~/.gitignore_global

echo "Configuring GPG"
mkdir -p ~/.gnupg
grep "pinentry-program" ~/.gnupg/gpg-agent.conf || echo "pinentry-program /usr/local/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
grep "no-tty"  ~/.gnupg/gpg.conf || echo "no-tty" >> ~/.gnupg/gpg.conf

echo "Installing iTerm shell integration"
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

echo "Install NVM"
nvm install stable

echo "Installing OH-MY-ZSH"
brew install antigen
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
