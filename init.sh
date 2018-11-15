#!/bin/bash

set -x

ME=`whoami`

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Configuring base directories..."
mkdir -p ~/Projects
sudo mkdir -p /opt
sudo chown -R "$ME":staff /opt

echo "Configuring base configs..."

echo "Installing and upgrading Brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew tap caskroom/versions

echo "Configuring GPG"
mkdir -p ~/.gnupg
brew install gpg
brew install gpg-agent
brew install pinentry-mac
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
echo "no-tty" >> ~/.gnupg/gpg.conf
gpgconf --kill gpg-agent

echo "Install Brew's software base"
brew install wget --with-iri
brew install autoconf
if [ "$1" == "advanced" ]; then
brew install imagemagick --with-webp
brew install graphicsmagick
brew install ffmpeg --with-libvorbis --with-libvpx
brew install libimobiledevice
brew install gettext 
brew install openssl 
brew install freetype  
brew install zlib
brew cask install java8
brew install ccache
brew cask install android-studio
brew install shellcheck
fi

echo "Install interpreters"
brew install node
brew install nvm

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
brew cask install cloudapp
if [ "$1" == "advanced" ]; then
brew cask install google-drive-file-stream
brew cask install google-backup-and-sync
brew cask install torbrowser
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install charles
brew cask install evernote
brew cask install gpgtools
brew cask install sqlpro-for-sqlite
brew cask install firefox
brew cask install transmission
brew cask install sketch
brew cask install paw
brew cask install poedit
brew cask install sip
brew cask install hex-fiend
brew cask install studio-3t
brew cask install fantastical
brew cask install sourcetree
brew cask install bettertouchtool
brew cask install little-snitch
fi

echo "Install Brew caskroom fonts"
brew tap caskroom/fonts
brew cask install font-iosevka

echo "Install Cloud's CLI"
brew install awscli
brew cask install google-cloud-sdk

echo "Installing other tools"
npm install -g fx

echo "Cleaning Brew"
brew cleanup
brew cask cleanup

echo "Goodbye!"
