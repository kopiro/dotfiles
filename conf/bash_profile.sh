#!/bin/bash

export CC=gcc # The name of the C compiler to use
export CXX=g++ # The name of the C++ compiler to use

export PAGER=less
export EDITOR=nano
export BROWSER=chrome 
export MPLAYER=vlc 
export XIVIEWER=ql

export LANG=en # The basic language setting used by applications on the system
export LC_ALL=en_SE.UTF-8 # This variable serves as a powerful override over all the other locale environment variables.
export LC_CTYPE=UTF-8 # The character set used to display and input text
export HOMEBREW_NO_ANALYTICS=1 # Tell to brew to not collect analytics data
export HOMEBREW_NO_AUTO_UPDATE=true # Tell to brew to not auto-update before brew intsall
export NVM_DIR=~/.nvm
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Change this accordingly to your system
export NDK_CCACHE=/usr/local/bin/ccache
export ANDROID_SDK=~/Library/Android/sdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-14.0.1.jdk/Contents/Home # $(/usr/libexec/java_home)
export BREW_PATH=/usr/local # $(brew --prefix)


# ZSH things
OHMYZSH_PLUGINS=(
autojump # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/autojump
last-working-dir # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/last-working-dir
docker # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
sudo # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
bgnotify # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/bgnotify
djui/alias-tips # https://github.com/djui/alias-tips
command-not-found # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found
zsh-users/zsh-completions # https://github.com/zsh-users/zsh-completions
zsh-users/zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
)

# Setup antigen
[ -f /usr/local/share/antigen/antigen.zsh ] && source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh
for plugin in "${OHMYZSH_PLUGINS[@]}"; do
  antigen bundle "$plugin"
done
antigen theme robbyrussell
antigen apply

# One letter alias
alias y='yarn'
alias g='git'
alias d='docker'
alias k='kubectl'
alias yw='yarn workspace'

# Syntactic sugar aliases
alias please='sudo'
alias sudoedit='sudo nano'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-debug="chrome --remote-debugging-port=9222"
alias urlencode='python3 -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias plistbuddy="/usr/libexec/PlistBuddy"
alias dc='docker-compose'
alias badge="tput bel"
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 7'"
alias md5sum="md5"
alias sha1sum="shasum"
alias gc="git checkout"
alias push="git push"
alias pull="git pull"
alias fetch="git fetch"
alias cmt="git commit"
alias stash="git stash"

# Common alias
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

alias zshrc='${=EDITOR} ~/.zshrc'
alias bashprofile='${=EDITOR} ~/.bash_profile'

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

#read documents
alias -s pdf=acroread
alias -s ps=gv
alias -s dvi=xdvi
alias -s chm=xchm
alias -s djvu=djview

#list whats inside packed file
alias -s zip="unzip -l"
alias -s rar="unrar l"
alias -s tar="tar tf"
alias -s tar.gz="echo "
alias -s ace="unace l"

# Open the current directory in a Finder window
ofd() {
  open_command "$PWD"
}

pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

pfs() {
  osascript 2>/dev/null <<EOF
    set output to ""
    tell application "Finder" to set the_selection to selection
    set item_count to count the_selection
    repeat with item_index from 1 to count the_selection
      if item_index is less than item_count then set the_delimiter to "\n"
      if item_index is item_count then set the_delimiter to ""
      set output to output & ((item item_index of the_selection as alias)'s POSIX path) & the_delimiter
    end repeat
EOF
}

cdf() {
  cd "$(pfd)" || return
}

pushdf() {
  pushd "$(pfd)" || return
}

ql() {
  (( $# > 0 )) && qlmanage -p "$*" &>/dev/null &
}

vnc() {
  open "vnc://$1"
}

# Remove .DS_Store files recursively in a directory, default .
rmdsstore() {
	find "${@:-.}" -type f -name .DS_Store -delete
}
  
flush() {
  dscacheutil -flushcache && 
  killall -HUP mDNSResponder
}

dkill() {
  docker kill "$(docker ps -q)"
}

http-sniff() {
  sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'
}

http-dump() {
  sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"
}

gam() {
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ "$branch" = "master" ]; then
    echo "Sorry, I can't do this when you're on master"
    return
  fi
  git commit -n --amend &&
  git push --force-with-lease
}

got() {
  git add . && 
  git commit -m "$1" &&
  git push
}

gcm() {
  git checkout master
}

gcmp() {
  git checkout master && git pull --rebase
}

grom() {
  git fetch origin && git rebase --hard origin/master
}

git-branch-purge() {
  git branch --merged | grep -E -v "(^\*|master|beta)" | xargs git branch -d
}

http-server() {
  port=${1:=8080}
  open "https://localhost:$port"
  python3 -m http.server "$port"
}

https-server() {
  port=${1:=8443}
  DIR="$HOME/.https-server"
  CRT="${DIR}/server.crt"
  KEY="${DIR}/server.key"
  KEY_NOPASS="${DIR}/server-nopass.key"
  PEM="${DIR}/server.pem"
  PASS="password"

  mkdir -p "${DIR}"
  if [ ! -f "${CRT}" ] || [ ! -f "${KEY}" ]; then
      echo "Geneating certificates (for the first time)..."
      openssl genrsa -aes256 -passout pass:"${PASS}" -out "${KEY}" 2048
      openssl req -new -key "${KEY}" -passin pass:"${PASS}" -out /tmp/server.csr
      openssl x509 -req -passin pass:"${PASS}" -days 1024 -in /tmp/server.csr -signkey "${KEY}" -out "${CRT}"
      openssl rsa -in "${KEY}" -out "${KEY_NOPASS}" -passin pass:"${PASS}"
      mv "${KEY_NOPASS}" "${KEY}"
      cat "${CRT}" "${KEY}" > "${PEM}"
  fi

  pip3 install twisted pyOpenSSL
  open "https://localhost:${port}"
  twistd -no web --path . --https="${port}" -c "${CRT}" -k "${KEY}"
}

nef-to-jpg() {
  mkdir -p ./JPG
  find . -name "*.NEF" -print0 | xargs -0 -P "$(sysctl -n hw.ncpu)" -I file sips -s format jpeg file --out ./JPG/file.jpg
}

socat-x11() {
  open -a XQuartz
  socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:"$DISPLAY"
}

tor-enable-proxy() {
  INTERFACE=${1:="Wi-Fi"}
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  # trap ctrl-c and call disable_proxy()
  disable_proxy() {
    sudo networksetup -setsocksfirewallproxystate $INTERFACE off
    echo "SOCKS proxy disabled."
  }
  trap disable_proxy INT

  sudo networksetup -setsocksfirewallproxy $INTERFACE 127.0.0.1 9050 off
  sudo networksetup -setsocksfirewallproxystate $INTERFACE on
  echo "SOCKS proxy 127.0.0.1:9050 enabled."

  echo "Starting Tor..."
  tor
}

upgrade() {
  brew update
  brew upgrade
  brew cask upgrade
  mas upgrade
}

ip() {
  ifconfig en0 | grep "inet " | cut -d " " -f 2
}


# NVM hook
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc

# Setup external integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -e ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
[ -s /usr/local/opt/nvm/nvm.sh ] && source /usr/local/opt/nvm/nvm.sh  # This loads nvm
[ -s /usr/local/opt/nvm/etc/bash_completion.d/nvm ] && source /usr/local/opt/nvm/etc/bash_completion.d/nvm  # This loads nvm bash_completion
[ -f /usr/local/bin/kubectl ] && source <(kubectl completion zsh)
