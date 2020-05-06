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
export HOMEBREW_NO_AUTO_UPDATE=1


# ZSH things
zsh_plugins=(
  paulirish/git-open
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
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
  command-not-found
  alexrochas/zsh-extract
)

source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh
for plugin in "${zsh_plugins[@]}"; do
  antigen bundle "$plugin"
done
antigen theme robbyrussell
antigen apply

# Syntactic sugar aliases
alias please='sudo'
alias g='git'
alias dr='docker'
alias dc='docker-compose'
alias sudoedit='sudo nano'
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

# Path definition
EXTRAPATH=~/.dotfiles/bin
EXTRAPATH=$EXTRAPATH:/usr/local/opt/curl/bin
EXTRAPATH=$EXTRAPATH:~/.composer/vendor/bin
# Android SDK binaries
EXTRAPATH=$EXTRAPATH:"$ANDROID_SDK/tools"
EXTRAPATH=$EXTRAPATH:"$ANDROID_SDK/build-tools"
EXTRAPATH=$EXTRAPATH:"$ANDROID_SDK/platform-tools"
EXTRAPATH=$EXTRAPATH:"$ANDROID_SDK/tools/bin"

PATH=$EXTRAPATH:$PATH
export PATH