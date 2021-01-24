#!/bin/bash

echo "Installing and upgrading Brew"
[ -s "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homeapps/install/master/install)"

brew analytics off

echo "Tapping Brew's"
for e in $(cat ./_apps/brewtap.txt); do brew tap "$e"; done
brew update

echo "Install Brew's software base"
for e in $(cat ./_apps/brewlist.txt); do brew install "$e"; done

echo "Install Cask's base"
for e in $(cat ./_apps/brewcasklist.txt); do brew install --cask "$e"; done

echo "Install MAS's apps"
brew install mas
for e in $(cat ./_apps/mas.txt); do mas install "$e"; done

echo "Cleaning"
qlmanage -r
brew cleanup
