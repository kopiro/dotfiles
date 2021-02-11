#!/bin/bash

if [ ! -f /usr/local/share/iterm2_shell_integration.zsh ]
then
    echo "Installing iTerm shell integration"
    curl -L https://iterm2.com/shell_integration/zsh -o /usr/local/share/iterm2_shell_integration.zsh
fi

if [ ! -f /usr/local/share/antigen.zsh ]
then
    echo "Installing Antigen"
    curl -L https://git.io/antigen -o /usr/local/share/antigen.zsh
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""