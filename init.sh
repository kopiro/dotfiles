#!/bin/bash
ME="$(whoami)"

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Configuring base directories..."
mkdir -p ~/Projects

# Make me owner of /opt
sudo mkdir -p /opt
sudo chown -R "$ME":staff /opt

# Make my binaries executables
chmod +x /opt/dotfiles/bin/*

echo "Installing and upgrading Brew"
[ -s "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew tap caskroom/cask
brew tap caskroom/versions
brew tap buo/cask-upgrade

echo "Install base dependencies"
# dependencies for Formulas and Casks
dependencies=(
  java
  xquartz
)
for app in "${dependencies[@]}"; do
  brew cask install --appdir="/Applications" "$app" --force
done

echo "Configuring GPG"
mkdir -p ~/.gnupg
brew install gpg gpg-agent pinentry-mac
grep "pinentry-program /usr/local/bin/pinentry-mac" ~/.gnupg/gpg.conf || echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
grep "no-tty"  ~/.gnupg/gpg.conf || echo "no-tty" >> ~/.gnupg/gpg.conf
gpgconf --kill gpg-agent

echo "Install Brew's software base"
brew_apps=(
    findutils
    moreutils
    wget
    autoconf
    imagemagick
    graphicsmagick
    ffmpeg
    libimobiledevice
    gettext 
    openssl 
    freetype  
    zlib
    ccache
    shellcheck
    telnet
    composer
    php-code-sniffer
    socat
    rmtrash
    terminal-notifier
    autojump
)
for app in "${brew_apps[@]}"; do
    brew install "$app"
done

echo "Installing NVM"
brew install nvm
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
. /usr/local/opt/nvm/nvm.sh
nvm install stable
nvm alias default stable

echo "Install Cask base"
cask_apps=(
    tunnelblick
    vlc
    slack
    alfred
    telegram
    sublime-text
    visual-studio-code
    iterm2
    the-unarchiver
    dash
    google-chrome
    transmit
    1password
    sequel-pro
    spotify
    firefox
    intellij-idea
    google-drive-file-stream
    google-backup-and-sync
    tor-browser
    charles
    notion
    gpgtools
    sqlpro-for-sqlite
    transmission
    sketch
    poedit
    hex-fiend
    github
    little-snitch
    postman
    google-hangouts
    wireshark
    google-cloud-sdk
    provisionql
    quicklookase
    quicklook-json 
    quicklook-csv
    qlcolorcode
    qlimagesize
    qlmarkdown
    qlprettypatch
    qlstephen
    qlvideo
    webpquicklook
    suspicious-package
    geekbench
    disk-inventory-x
    vmware-fusion8
)

for app in "${cask_apps[@]}"; do
  brew cask install --appdir="/Applications" "$app" --force
done

echo "Cleaning Brew"
brew cleanup
brew cask cleanup

echo "Goodbye!"