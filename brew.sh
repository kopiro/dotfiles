#!/bin/bash

echo "Installing and upgrading Brew"
[ -s "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew_taps=(
'buo/cask-upgrade'
'homebrew/bundle'
'homebrew/core'
)
for tap in "${brew_taps[@]}"; do brew tap "$tap"; done

# Update to reflect taps
brew update

echo "Install Brew's software base"
brew_apps=(
# GNU
coreutils
findutils
git
git-lfs
inetutils
moreutils
openssl 
socat
wget
gpg
fzf
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
node
nvm
# Linters
shellcheck
php-code-sniffer
hadolint
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
iperf3
)

for app in "${brew_apps[@]}"; do brew install "$app"; done

echo "Install Cask base"
cask_apps=(
# Interpreters / Frameworks
java
xquartz
# Programming
charles
iterm2
sequel-pro
sublime-text
visual-studio-code
# Browsers
firefox
google-chrome
tor-browser
# Chat
slack
telegram
# Generic
1password
1password-cli
alfred
dash
google-backup-and-sync
google-cloud-sdk
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
docker
appcleaner
colorpicker-skalacolor
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
)

for app in "${cask_apps[@]}"; do brew cask install "$app"; done

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
'1091189122' # Bear
'775737590' # iA Writer
'1063631769' # Medis
)

for app in "${mas_apps[@]}"; do mas install "$app"; done

echo "Upgrading brew"
brew upgrade
brew cask upgrade

echo "Cleaning Brew"
brew cleanup