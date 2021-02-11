# shellcheck shell=bash

export CC=gcc # The name of the C compiler to use
export CXX=g++ # The name of the C++ compiler to use

export PAGER=less
export EDITOR=nano
export BROWSER=firefox 
export MPLAYER=vlc 
export XIVIEWER=ql

# LC stuff
export LANG=en # The basic language setting used by applications on the system
export LC_ALL=en_US.UTF-8 # This variable serves as a powerful override over all the other locale environment variables.
export LC_CTYPE=UTF-8 # The character set used to display and input text

# Brew stuff
export HOMEBREW_NO_ANALYTICS=1 # Tell to brew to not collect analytics data
export HOMEBREW_NO_AUTO_UPDATE=true # Tell to brew to not auto-update before brew intsall

# System paths
export NVM_DIR=~/.nvm
export NDK_CCACHE=/usr/local/bin/ccache
export ANDROID_SDK=~/Library/Android/sdk
export CLOUDSDK_PYTHON=/usr/local/opt/python@3.9/libexec/bin/python
[ -f /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home)
[ -f /usr/local/bin/brew ] && export BREW_PATH=$(/usr/local/bin/brew --prefix)

# ZSH things
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_THEME=xiong-chiamiov-plus
export DISABLE_AUTO_UPDATE=true
export ZSH_THEME_GIT_PROMPT_CACHE=1

# Adding some specific bin paths at the end
PATH=$PATH:/usr/local/sbin
# External binaries
PATH=~/Library/Python/3.9/bin:$PATH
[ -d ~/.bin ] && PATH=~/.bin:$PATH
export PATH

# Colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'

echo-succ() {
  echo -e "${GREEN}${1}"
}
echo-fail() {
  echo -e "${RED}${1}"
}
echo-warn() {
  echo -e "${YELLOW}${1}"
}

# Setup antigen
if [ -f /usr/local/share/antigen/antigen.zsh ]
then
  source /usr/local/share/antigen/antigen.zsh
  antigen use oh-my-zsh

  ANTIGEN_PLUGINS=(
    git # https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git
    autojump # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/autojump
    last-working-dir # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/last-working-dir
    docker # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
    sudo # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
    bgnotify # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/bgnotify
    git-prompt # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-prompt
    djui/alias-tips # https://github.com/djui/alias-tips
    command-not-found # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found
    zsh-users/zsh-completions # https://github.com/zsh-users/zsh-completions
    zsh-users/zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
  )

  for f in "${ANTIGEN_PLUGINS[@]}"
  do 
    antigen bundle "$f"
  done
  antigen theme $ZSH_THEME
  antigen apply
fi

# One letter alias
alias y='yarn'
alias n='npm'
alias g='git'
alias d='docker'
alias k='kubectl'

# Two letter alias
alias yw='yarn workspace'
alias dc='docker-compose'

# Syntactic sugar aliases
alias please='sudo'
alias sudoedit='sudo nano'
alias firefox='/Applications/Firefox.app/Contents/MacOS/firefox'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-debug="chrome --remote-debugging-port=9222"
alias urlencode='python3 -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias plistbuddy="/usr/libexec/PlistBuddy"
alias badge="tput bel"
alias mute="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 7'"
alias md5sum="md5"
alias sha1sum="shasum"

# Git Aliases
alias gmaster="git checkout master && git pull origin master"
alias gmain="git checkout main && git pull origin main"

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

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f -n 100'

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

# QuickLook file
ql() {
  (( $# > 0 )) && qlmanage -p "$*" &>/dev/null &
}

# Kubernetes exec shell on pod
kex() {
  kubectl exec --stdin --tty "$1" -- /bin/sh
}

# Docker exec shell on container
dex() {
  docker exec -it "$1" /bin/sh
}

# Docker-compose exec shell on container
dcex() {
  docker-compose exec -it "$1" /bin/sh
}

# Remove .DS_Store files recursively in a directory, default .
rmdsstore() {
	find "${@:-.}" -type f -name .DS_Store -delete
}

# Flushing cache of DNSs
dns-flush() {
  dscacheutil -flushcache && 
  killall -HUP mDNSResponder
}

# Stop all docker containers
dstop() {
  docker stop "$(docker ps -aq)"
}

# Stop and remove all docker container
drm() {
  docker stop "$(docker ps -aq)" && docker rm "$(docker ps -aq)"
}

# Simple commit and push
got() {
  git commit -m "$1" &&
  git push
}

# Simple commit and push (skip pre-commits)
gotn() {
  git commit -n -m "$1" &&
  git push
}

# Git amend and push (forced)
gotf() {
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ "$branch" = "master" ] && [ "$1" != "-f" ]
  then
    echo "Sorry, I can't do this when you're on master"
    return
  fi
  git commit -n --amend --no-edit &&
  git push --force-with-lease
}

# Sync this branch with origin/master
gsync() {
  git fetch origin && git rebase origin/master
}

# Prune GIT tree
gprune() {
  git gc --aggressive --prune
  git branch --merged | grep -E -v "(^\*|master|beta)" | xargs git branch -d
}

# Spawn an HTTP server on current dir
http-server() {
  port=${1:=8080}
  open "https://localhost:$port"
  python3 -m http.server "$port"
}

# Spawn an HTTPS server on current dir
# It will generate a key/cert first time
https-server() {
  port=${1:=8443}
  DIR="$HOME/.https-server"
  CRT="${DIR}/server.crt"
  KEY="${DIR}/server.key"
  KEY_NOPASS="${DIR}/server-nopass.key"
  PEM="${DIR}/server.pem"
  PASS="password"

  mkdir -p "${DIR}"
  if [ ! -f "${CRT}" ] || [ ! -f "${KEY}" ]
  then
      echo "Geneating certificates and saving them in ${DIR}..."
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

# Using Linux Display on OSX in docker 
socat-x11() {
  open -a XQuartz
  socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:"$DISPLAY"
}

# Enable TOR proxy and set it as system proxy
tor-enable-proxy() {
  INTERFACE=${1:="Wi-Fi"}
  sudo -v
  while true
  do 
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &

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

# Upgrade the whole system
upgrade() {
  set -x
  brew update
  brew upgrade
  brew cask upgrade
  mas upgrade
  omz update
  set +x
}

# Get all IPs from interfaces
ip() {
  /sbin/ifconfig | grep "inet " | cut -d " " -f 2
}

# Get all possible actions on package.json
pkgj-run-list() {
  jq .scripts package.json | grep -o '.*\":' | sed -nE 's/\"(.*)\":/\1/p' | awk '{$1=$1};1' | fzf | tr -d '\r' | tr -d '\n'
}

yarn-x() {
  PKG_CMD=$(pkgj-run-list)
  [ -n "$PKG_CMD" ] && print -s "yarn $PKG_CMD" && yarn "$PKG_CMD"
}
alias yx="yarn-x"

npm-x() {
  PKG_CMD=$(pkgj-run-list)
  [ -n "$PKG_CMD" ] && print -s "npm run $PKG_CMD" && npm run "$PKG_CMD"
}
alias nx="npm-x"

# Forward mic to speakers
hear-myself() {
   sox --buffer 128 -d -d
}

# Setup external integrations
EXTERNAL_SOURCES=(
  /usr/local/share/iterm2_shell_integration.zsh
  ~/.config/broot/launcher/bash/br
  /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  $BREW_PATH/opt/nvm/nvm.sh
  $NVM_DIR/nvm.sh
  ~/.bash_profile_custom
)
for f in "${EXTERNAL_SOURCES[@]}"
do
  if [ -f "$f" ]
  then
    source "$f"
  fi
done

if [ -f /usr/local/bin/kubectl ] 
then
  source <(kubectl completion zsh)
fi


# NVM hook
if command -v nvm > /dev/null
then
  autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]
    then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]
      then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]
      then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]
    then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd load-nvmrc
fi


if command -v autoload &> /dev/null
then autoload -Uz compinit && compinit
fi