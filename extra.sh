#!/bin/bash

echo "Configuring GPG"
brew install pinentry-mac
grep "pinentry-program" ~/.gnupg/gpg-agent.conf || echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
grep "no-tty"  ~/.gnupg/gpg.conf || echo "no-tty" >> ~/.gnupg/gpg.conf

echo "Installing iTerm shell integration"
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash