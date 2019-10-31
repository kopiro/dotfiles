#!/bin/bash
ME="$(whoami)"

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

set -x

echo "Configuring base directories..."

# Create project directory
mkdir -p ~/Projects

# Make me owner of /opt
sudo mkdir -p /opt
sudo chown -R "$ME":staff /opt

# Make my binaries executables
chmod +x /opt/dotfiles/bin/*

echo "Installing and upgrading Brew"
[ -s "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew_taps=(
  'buo/cask-upgrade'
  'homebrew/bundle'
  'homebrew/core'
)
for tap in "${brew_taps[@]}"; do
    brew tap "$tap"
done

# Update to reflect taps
brew update

echo "Install Brew's software base"
brew_apps=(
    # GNU
    coreutils
    findutils
    git
    inetutils
    moreutils
    openssl 
    socat
    wget
    grep
    # Compilation
    autoconf
    freetype  
    ccache
    # Image
    imagemagick
    graphicsmagick
    # Video
    ffmpeg
    # iPhone
    ideviceinstaller
    libimobiledevice
    # Lang
    gettext 
    # Compression
    zlib
    # Interpreters
    php
    python
    go
    # Linters
    shellcheck
    php-code-sniffer
    # Installers
    composer
    yarn
    # Shell / CLI
    autojump
    rmtrash
    terminal-notifier
    # Security
    sqlmap
    nmap
    # Tools
    geoip
    htop
    mas
    midnight-commander
    ripgrep
    sqlite
    tldr
    wifi-password
    youtube-dl
)
for app in "${brew_apps[@]}"; do
    brew install "$app"
done

echo "Install Cask base"
cask_apps=(
    # Interpreters / Frameworks
    java
    java8
    xquartz
    # Programming
    charles
    intellij-idea
    iterm2
    sequel-pro
    sublime-text
    visual-studio-code
    # Browsers
    chromium
    firefox
    google-chrome
    opera
    tor-browser
    # Chat
    slack
    telegram
    # Generic
    1password
    1password-cli
    alfred
    cakebrew
    dash
    disk-inventory-x
    geekbench
    github
    google-backup-and-sync
    google-cloud-sdk
    google-drive-file-stream
    google-hangouts
    hex-fiend
    little-snitch
    notion
    poedit
    postman
    sketch
    spotify
    sqlpro-for-sqlite
    the-unarchiver
    transmission
    transmit
    tunnelblick
    vlc
    vmware-fusion8
    wireshark
    # Finder addons
    provisionql
    qlcolorcode
    qlimagesize
    qlmarkdown
    qlprettypatch
    qlstephen
    qlvideo
    quicklook-csv
    quicklook-json 
    quicklookase
    suspicious-package
    webpquicklook
)

for app in "${cask_apps[@]}"; do
  brew cask install "$app"
done

echo "Install MAS's apps"
brew install mas
mas_apps=(
    '497799835' # Xcode
    '441258766' # Magnet
    '409183694' # Keynote
    '408981434' # iMovie
    '597790822' # SSH Proxy
    '734418810' # SSH Tunnel
    '682658836' # GarageBand
    '409203825' # Numbers
)

for app in "${mas_apps[@]}"; do
  mas install "$app"
done

echo "Installing NVM"
brew install nvm
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
. /usr/local/opt/nvm/nvm.sh
nvm install stable
nvm alias default stable

echo "Configuring GPG"
brew install gpg 
brew install pinentry-mac
mkdir -p ~/.gnupg
grep "pinentry-program /usr/local/bin/pinentry-mac" ~/.gnupg/gpg-agent.conf || echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
grep "no-tty"  ~/.gnupg/gpg.conf || echo "no-tty" >> ~/.gnupg/gpg.conf

echo "Cleaning Brew"
brew cleanup

echo "Goodbye!"