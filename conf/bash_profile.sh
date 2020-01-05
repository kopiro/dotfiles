export CC="gcc"
export CXX="g++"
export EDITOR="nano"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANGUAGE="en"
export LANG="en"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export JAVA_HOME=`/usr/libexec/java_home`
export BREW_PATH=`brew --prefix`
export ANDROID_SDK="$HOME/Library/Android/sdk"
export ANDROID_NDK="/Library/Android/sdk/ndk-bundle"
export NDK_CCACHE="/usr/local/bin/ccache"

# Path definition
PATH=$PATH:~/.dotfiles/bin
# Specific bins
PATH=$PATH:~/.yarn/bin
PATH=$PATH:~/.composer/vendor/bin
# Android SDK binaries
PATH=$PATH:"$ANDROID_SDK/tools"
PATH=$PATH:"$ANDROID_SDK/build-tools"
PATH=$PATH:"$ANDROID_SDK/platform-tools"
PATH=$PATH:"$ANDROID_SDK/tools/bin"
# Default bin/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/bin
PATH=$PATH:/sbin
export PATH

# ZSH things
ZSH_THEME="robbyrussell"
plugins=(
autojump
common-aliases
git-extras
gitfast 
osx 
jsontools 
last-working-dir 
extract
npm 
yarn
copyfile 
docker 
sudo
bgnotify
alias-tips
vscode
zsh-autosuggestions
)

# Syntactic sugar aliases
alias please='sudo'

# Docker aliases
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcub='docker-compose up --build'
alias d-kill='docker rm -f $(docker container ls -aq)' # Kill all containers
alias d-img-prune='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
alias d-vol-prune='docker volume rm $(docker volume ls -qf dangling=true)'
alias d-erase='docker system prune --all --force --volumes' # Erase the docker system

# Useful aliases
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-debug="chrome --remote-debugging-port=9222"

# iTerm shell integration
test -e ~/.iterm2_shell_integration.zsh && . ~/.iterm2_shell_integration.zsh

# This loads nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"
