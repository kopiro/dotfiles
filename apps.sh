#!/bin/bash

echo "Installing and upgrading Brew"
[ -s "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Tapping Brew's"
cat brewtap.txt | xargs brew tap
brew update

echo "Install Brew's software base"
cat brewlist.txt | xargs brew install

echo "Install Cask's base"
cat casklist.txt | xargs brew cask install

echo "Install MAS's apps"
brew install mas
cat mas.txt | xargs mac install

echo "Cleaning Brew"
brew cleanup
