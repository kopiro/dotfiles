# shellcheck shell=bash

export CC=gcc # The name of the C compiler to use
export CXX=g++ # The name of the C++ compiler to use

export PAGER=less
export EDITOR=nano
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
export ANDROID_SDK=~/Library/Android/sdk
export CLOUDSDK_PYTHON=/usr/local/opt/python@3.9/libexec/bin/python
export BREW_PATH=/usr/local
[ -f /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home)

# ZSH things
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_THEME=dpoggi
export DISABLE_AUTO_UPDATE=true
export ZSH_THEME_GIT_PROMPT_CACHE=1

# Adding some specific bin paths at the end
PATH=$PATH:/usr/local/sbin
PATH=$PATH:~/Library/Python/3.9/bin
# My binaries
PATH=~/.bin:$PATH
PATH=~/.dotfiles/bin:$PATH
export PATH

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
    bgnotify # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/bgnotify
    zsh-users/zsh-completions # https://github.com/zsh-users/zsh-completions
    zsh-users/zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
    zsh-users/zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
  )

  for f in "${ANTIGEN_PLUGINS[@]}"
  do antigen bundle "$f"
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

# Common alias
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias h='head -n 100'
alias t='tail -f -n 100'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

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

# Stop all docker containers
dstop() {
  docker stop "$(docker ps -aq)"
}

# Stop and remove all docker container
drm() {
  docker stop "$(docker ps -aq)"
  docker rm "$(docker ps -aq)"
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
    echo "Sorry, I can't do this when you're on master - run gotf -f"
    return
  fi
  git commit -n --amend --no-edit &&
  git push --force-with-lease
}

# Sync this branch with origin/master
gsync() {
  git fetch origin && git rebase origin/master
}

# Checkout this branch on origin/master
gmaster() {
  git checkout master && git pull
}

# Prune GIT tree
gprune() {
  git gc --aggressive --prune
  git branch --merged | grep -E -v "(^\*|master|beta)" | xargs git branch -d
}

# Get all IPs from interfaces
ip() {
  /sbin/ifconfig | grep "inet " | cut -d " " -f 2
}

yx() {
  PKG_CMD=$(jq .scripts package.json | grep -o '.*\":' | sed -nE 's/\"(.*)\":/\1/p' | awk '{$1=$1};1' | fzf | tr -d '\r' | tr -d '\n')
  [ -n "$PKG_CMD" ] && print -s "yarn $PKG_CMD" && yarn "$PKG_CMD"
}

# Forward mic to speakers
hear-myself() {
   sox --buffer 128 -d -d
}

# Setup external integrations
EXTERNAL_SOURCES=(
  # /usr/local/share/iterm2_shell_integration.zsh
  # ~/.config/broot/launcher/bash/br
  # /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  # /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  "$BREW_PATH/opt/nvm/nvm.sh"
  "$NVM_DIR/nvm.sh"
  ~/.bash_profile_custom
)
for f in "${EXTERNAL_SOURCES[@]}"
do
  if [ -f "$f" ]
  then
    source "$f"
  fi
done

# GKE completions
# if [ -f /usr/local/bin/kubectl ] 
# then
#   source <(kubectl completion zsh)
# fi

if command -v autoload &> /dev/null
then autoload -Uz compinit && compinit
fi