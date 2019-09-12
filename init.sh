#!/bin/bash
if [ -z "$1" ]; then
    echo "Please specify your environment as a first argument: like ./init.sh work"
    exit 1
fi

ME="$(whoami)"

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Configuring base directories..."
mkdir -p ~/Projects

sudo mkdir -p /opt
sudo chown -R "$ME":staff /opt
chmod +x /opt/dotfiles/bin/*

echo "Installing and upgrading Brew"
[ -s "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew tap caskroom/versions

echo "Install Brew's software base"
brew install wget
brew install autoconf

if [ "$1" == "work" ]; then
brew install imagemagick --with-webp
brew install graphicsmagick
brew install ffmpeg
brew install libimobiledevice
brew install gettext 
brew install openssl 
brew install freetype  
brew install zlib
brew cask install java8
brew install ccache
brew install shellcheck
brew install telnet
brew install composer
brew install php-code-sniffer
brew install socat
brew install rmtrash
brew install terminal-notifier
brew install autojump
fi

echo "Install missing interpreters"
brew install nvm
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
. /usr/local/opt/nvm/nvm.sh
nvm install stable
nvm alias default stable

echo "Install Docker"
brew cask install docker

echo "Install Cask base"
brew cask install tunnelblick
brew cask install vlc
brew cask install slack
brew cask install alfred
brew cask install telegram
brew cask install sublime-text
brew cask install visual-studio-code
brew cask install iterm2
brew cask install the-unarchiver
brew cask install dash
brew cask install google-chrome
brew cask install transmit
brew cask install 1password
brew cask install sequel-pro
brew cask install spotify
brew cask install firefox
brew cask install android-studio

if [ "$1" == "work" ]; then
brew cask install google-drive-file-stream
brew cask install google-backup-and-sync
brew cask install torbrowser
brew cask install charles
brew cask install notion
brew cask install gpgtools
brew cask install sqlpro-for-sqlite
brew cask install transmission
brew cask install sketch
brew cask install paw
brew cask install poedit
brew cask install hex-fiend
brew cask install sourcetree
brew cask install bettertouchtool
brew cask install little-snitch
brew cask install xquartz
fi

echo "Install Cloud's CLI"
brew install awscli
brew cask install google-cloud-sdk

echo "Configuring GPG"
mkdir -p ~/.gnupg
brew install gpg
brew install gpg-agent
brew install pinentry-mac
grep "pinentry-program /usr/local/bin/pinentry-mac" ~/.gnupg/gpg.conf || echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
grep "no-tty"  ~/.gnupg/gpg.conf || echo "no-tty" >> ~/.gnupg/gpg.conf
gpgconf --kill gpg-agent

echo "Cleaning Brew"
brew cleanup
brew cask cleanup

echo "Goodbye!"