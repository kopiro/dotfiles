#!/bin/bash

echo "Installing and upgrading Brew"
[ -s "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew analytics off

echo "Tapping Brew's"
for e in $(cat brewtap.txt); do brew tap $e; done
brew update

echo "Install Brew's software base"
for e in $(cat brewlist.txt); do brew install $e; done

echo "Install Cask's base"
for e in $(cat brewcasklist.txt); do brew cask install $e; done

echo "Install MAS's apps"
brew install mas
for e in $(cat mas.txt); do mas install $e; done

echo "Cleaning"
qlmanage -r
brew cleanup
