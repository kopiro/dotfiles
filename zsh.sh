#!/bin/bash
set -x
brew install zsh
echo "export ZSH=$HOME/.oh-my-zsh
source $HOME/.bash_profile
source $ZSH/oh-my-zsh.sh" > $HOME/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
