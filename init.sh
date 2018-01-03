#!/usr/bin/env bash

ME=`whoami`
DIR=`pwd`
MYHOST=`scutil --get ComputerName`

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Setting your system info..."
sudo scutil --set LocalHostName "$MYHOST"
sudo scutil --set HostName "$MYHOST"

echo "Configuring base directories..."
mkdir -p ~/Library/LaunchAgents
mkdir -p ~/Sites
sudo ln -sf ~/Sites /var/www
sudo mkdir -p /opt
sudo chown -R "$ME":staff /opt

echo "Configuring things..."
echo 'no-tty' >> ~/.gnupg/gpg.conf

echo "Installing and upgrading Brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

echo "Install ZSH"
brew install zsh zsh-completions

echo "Install Brew's software base"
brew install coreutils
brew install moreutils
brew install findutils
brew install curl --force
brew install gnu-sed --with-default-names
brew install wget --with-iri
brew install autoconf
brew install imagemagick --with-webp
brew install gettext 
brew install openssl 
brew install git 
brew install freetype 
brew install jpeg 
brew install libpng 
brew install gd 
brew install zlib

echo "Install interpreters"
brew install node
# brew install python3

echo "Install Brew's etical hacking tools"
brew install sqlmap
brew install ab
brew install tor

echo "Install Brew's Web Server"

brew install nginx
sudo cp /usr/local/opt/nginx/*.plist /Library/LaunchDaemons
sudo chown root:wheel /Library/LaunchDaemons/homebrew.mxcl.nginx.plist

brew install mariadb
ln -sf /usr/local/opt/mariadb/*.plist ~/Library/LaunchAgents

brew install php70 --with-imagick --with-fpm --with-homebrew-curl
brew install php70-mcrypt php70-imagick
ln -sf /usr/local/opt/php70/*.plist ~/Library/LaunchAgents

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
brew cask install virtualbox-extension-pack
brew cask install charles
brew cask install evernote
brew cask install gpgtools
brew cask install iterm2
brew cask install dash
brew cask install robomongo
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

echo "Install NodeJS stuffs"
npm -g install yarn
npm -g install eslint

echo "Installing Titanium stuffs"
chmod +x .titanium.sh
source .titanium.sh

# echo "Install PIP3"
# curl https://bootstrap.pypa.io/get-pip.py -p /tmp/get-pip.py
# /usr/local/bin/python3 /tmp/get-pip.py --user
# rm /tmp/get-pip.py

echo "Install PECL"
curl http://pear.php.net/go-pear.phar -o /tmp/go-pear.phar
sudo /usr/local/bin/php -d detect_unicode=0 /tmp/go-pear.phar
rm /tmp/go-pear.phar

echo "Install Cloud's CLI"
brew install awscli
brew cask install google-cloud-sdk

echo "Setup MacOS"
chmod +x .macos.sh
source .macos.sh

echo "Setup MacOS privacy..."
export PYTHONPATH="/Library/Frameworks/Python.framework/Versions/2.5/lib/python2.5/site-packages/PyObjC/"
chmod +x .macos-privacy.sh
source .macos-privacy.sh

echo "Cleaning Brew"
brew cleanup

echo "Goodbye!"