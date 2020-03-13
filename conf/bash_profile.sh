export CC="gcc"
export CXX="g++"
export EDITOR="nano"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANGUAGE="en"
export LANG="en"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export JAVA_HOME=$(/usr/libexec/java_home)
export BREW_PATH=$(brew --prefix)
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
zsh_plugins=(
  paulirish/git-open
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  autojump
  common-aliases
  git-extras
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
)

source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh
for plugin in "${zsh_plugins[@]}"; do
  antigen bundle "$plugin"
done
antigen theme nanotech
antigen apply

# Syntactic sugar aliases
alias please='sudo'
alias g='git'
alias sudoedit='sudo nano'

# Docker aliases
alias dc='docker-compose'
alias d-kill='docker rm -f $(docker container ls -aq)' # Kill all containers
alias d-vol-prune='docker volume rm $(docker volume ls -qf dangling=true)'
alias d-erase='docker system prune --all --force --volumes' # Erase the docker system

# Other aliases
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-debug="chrome --remote-debugging-port=9222"

# iTerm shell integration
test -e ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh

export NVM_DIR=~/.nvm
[ -s /usr/local/opt/nvm/nvm.sh ] && source /usr/local/opt/nvm/nvm.sh  # This loads nvm
[ -s /usr/local/opt/nvm/etc/bash_completion.d/nvm ] && source /usr/local/opt/nvm/etc/bash_completion.d/nvm  # This loads nvm bash_completion

# place this after nvm initialization!
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
load-nvmrc
