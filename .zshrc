export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="pygmalion"
plugins=(git osx jsontools last-working-dir npm sublime zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Aliases
alias sj="st app.sublime-project"
alias fuck='$(thefuck $(fc -ln -1))'
alias rm='rm -i'
alias qlf='qlmanage -p "$@" &gt;& /dev/null'

alias dc='docker-compose'
alias dcu='docker-compose up --build'
alias dcud='docker-compose up -d --build'
alias dkill='docker ps -q | xargs docker kill'

# Variables
export CC="gcc"
export CXX="g++"
export EDITOR=nano
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANGUAGE=en
export LANG=en
export NODE_PATH=/usr/local/lib/node_modules
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export TITANIUM_SDK=~/Library/Application\ Support/Titanium/mobilesdk/osx
export GOOGLE_APIS=/opt/android/add-ons/addon-google_apis-google-23
export JAVA_HOME=`/usr/libexec/java_home`
export BREW_PATH=`brew --prefix`
export NDK_CCACHE=/usr/local/bin/ccache
export NUM_CPUS=8
export NODE_ENV="development"

# Path
PATH=''
PATH=$PATH:/opt/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/bin
PATH=$PATH:/sbin
export PATH

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
