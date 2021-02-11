#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then

echo "Installing and upgrading Brew"
[ -s "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homeapps/install/master/install)"

brew analytics off

echo "Tapping Brew's"
for e in $(cat ./_apps/brewtap.txt); do brew tap "$e"; done
brew update

echo "Install Brew's software base"
for e in $(cat ./_apps/brew.txt); do brew install "$e"; done

echo "Install Cask's base"
for e in $(cat ./_apps/brewcasklist.txt); do brew install --cask "$e"; done

echo "Install MAS's apps"
brew install mas
for e in $(cat ./_apps/mas.txt); do mas install "$e"; done

echo "Cleaning"
qlmanage -r
brew cleanup

elif [[ "$OSTYPE" == "linux"* ]]; then

echo "Updating APT"
sudo apt update

echo "Install APT's software base"
for e in $(cat ./_apps/apt.txt); do sudo apt install -y "$e"; done

echo "Cleaning"
sudo apt clean

else

echo "$OSTYPE is not supported"
exit 1

fi