#!/bin/bash

if [ ! -d ~/.oh-my-zsh ]; then
echo "Installing OH-MY-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# chsh -s $(which zsh)
fi

echo "Installing Antigen"
if [[ "$OSTYPE" == "darwin"* ]]; then
brew install antigen
elif [[ "$OSTYPE" == "linux"* ]]; then
sudo apt-get install zsh-antigen
fi

if [ ! -f ~/.iterm2_shell_integration.zsh ]; then
if [[ "$OSTYPE" == "darwin"* ]]; then
echo "Installing iTerm shell integration"
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
fi
fi

echo "Linking configurations"
ln -svf ~/.dotfiles/conf/zshrc.sh ~/.zshrc
ln -svf ~/.dotfiles/conf/bash_profile.sh ~/.bash_profile
ln -svf ~/.dotfiles/conf/gitconfig.txt ~/.gitconfig
ln -svf ~/.dotfiles/conf/gitignore.txt ~/.gitignore_global
touch ~/.bash_profile_custom
