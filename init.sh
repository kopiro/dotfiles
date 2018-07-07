#!/bin/bash

ME=`whoami`

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Configuring base directories..."
mkdir -p ~/Library/LaunchAgents
mkdir -p ~/Projects
sudo mkdir -p /opt
sudo chown -R "$ME":staff /opt

echo "Configuring base configs..."
echo 'no-tty' >> ~/.gnupg/gpg.conf

echo "Installing and upgrading Brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

echo "Install Brew's software base"
brew install coreutils
brew install moreutils
brew install findutils
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install autoconf
if [ "$1" == "advanced" ]; then
brew install curl --force
brew install imagemagick --with-webp
brew install graphicsmagick
brew install gd 
brew install ffmpeg --with-libvorbis --with-libvpx
brew install libimobiledevice
brew install gettext 
brew install openssl 
brew install git 
brew install freetype  
brew install zlib
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
brew cask install google-drive
brew cask install spotify
brew cask install cloudapp
if [ "$1" == "advanced" ]; then
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
brew cask install sourcetree
fi

echo "Install Brew caskromm fonts"
brew tap caskroom/fonts

echo "Install Cloud's CLI"
brew install awscli
brew cask install google-cloud-sdk

echo "Cleaning Brew"
brew cleanup
brew cask cleanup

echo "Goodbye!"
