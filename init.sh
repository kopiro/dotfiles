#!/usr/bin/env bash

ME=`whoami`
DIR=`pwd`

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Configuring base directories..."
mkdir -p ~/Library/LaunchAgents
mkdir -p ~/Sites
mkdir -p ~/Projects
mkdir -p ~/Repos
sudo ln -sf ~/Sites /var/www
sudo mkdir -p /opt
sudo chown -R "$ME":staff /opt

echo "Installing and upgrading Brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

echo "Install Brew's software base"
brew install coreutils
brew install moreutils
brew install findutils
brew install curl --force
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install autoconf
brew install imagemagick --with-webp
brew install gd 
brew install gettext 
brew install openssl 
brew install git 
brew install freetype  
brew install zlib
brew install ffmpeg --with-libvorbis --with-libvpx

echo "Install interpreters"
brew install node
brew cask install java
# brew install python3

echo "Install Brew's etical hacking tools"
brew install sqlmap
brew install ab
brew install tor
brew install nmap

echo "Install Brew's Web Server"

brew install nginx
ln -sf /usr/local/opt/nginx/*.plist ~/Library/LaunchAgents

brew install mariadb
ln -sf /usr/local/opt/mariadb/*.plist ~/Library/LaunchAgents

brew tap homebrew/homebrew-php
brew install php71 --with-homebrew-curl
brew install php71-mcrypt php71-imagick
ln -sf /usr/local/opt/php71/*.plist ~/Library/LaunchAgents

brew install redis
ln -svf /usr/local/opt/redis/*.plist ~/Library/LaunchAgents

echo "Install Brew Cask's software base"
brew cask install smcfancontrol
brew cask install vlc
brew cask install slack
brew cask install alfred
brew cask install telegram
brew cask install sublime-text
brew cask install torbrowser
brew cask install virtualbox
brew cask install charles
brew cask install evernote
brew cask install gpgtools
brew cask install iterm2
brew cask install dash
brew cask install sparkleshare
brew cask install sqlpro-for-sqlite
brew cask install the-unarchiver
brew cask install transmit
brew cask install google-chrome
brew cask install firefox
brew cask install 1password
brew cask install skype
brew cask install sequel-pro
brew cask install google-drive
brew cask install odrive
brew cask install tower
brew cask install spotify
brew cask install transmission

echo "Install NodeJS stuffs"
npm -g install yarn
npm -g install eslint

echo "Install PECL"
curl http://pear.php.net/go-pear.phar -o /tmp/go-pear.phar
sudo /usr/local/bin/php -d detect_unicode=0 /tmp/go-pear.phar
rm /tmp/go-pear.phar

echo "Install Cloud's CLI"
brew install awscli
brew cask install google-cloud-sdk

echo "Cleaning Brew"
brew cleanup

echo "Goodbye!"
