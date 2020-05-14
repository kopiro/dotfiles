# kopiro's (.)files

This repository reflects my personal macOS setup.

## Installation

You must clone the repository under `~/.dotfiles`.

```shell
cd ~ && git clone git@github.com:kopiro/dotfiles.git .dotfiles
```

## Scripts

#### `./brew.sh`

This is the main script; it will:

- Create the base directories

- Install `brew` and install several taps
- Install base tools
  - GNU utils like `findutils`, `coreutils`, `inetutils`, `moreutils`
  - Compilation helpers like `autoconf` or `ccache`
  - Image/Video manipulation tools like `ffmpeg`
  - Install `mas` to install App Store apps
  - Linters like `shellcheck`
  - Installers like `yarn`, `composer`
  - Interpreters like `php`, `python`, `go`
  - Security tools like `nmap`, `sqlmap`
  - Other tools
- Install casks (macOS apps)
- Install macOS app store apps
- Install and configure Node Version Manager (`nvm`)
- Install and configure GPG with pinentry

### `./macos.sh`

This will set several useful sensible defaults for developers; some opinionated.

### `shell.sh`

This will install `zsh` shell and `oh-my-zsh`

### `./conf-linker.sh`

This will link several configurations file in the appropriate locations:

- `~/.bash_profile`: Bash profile (you should include this file in your `~/.zshrc` if you're using oh-my-zsh)
- `~/.eslintrc.json`: Global basic eslint configuration for all projects
- `~/.editorconfig`: EditorConfig file
- `~/.gitignore_global`: Global very basic .gitignore for the entire system related to macOS

### Binaries

You can find several binaries in `./bin` - these are already in your `$PATH` if you use my `~/.bash_profile`.

### `backup-repos`

To execute in a directory that contains directories of GIT repositories, this will tgz all repos using `%Y%m%d` as a suffix.

### `gam`

GIT commit with amend and pre-commit hook disables, then force push (with lease) (⚠️ first add files using `git add`).

### `got`

```shell
got "${message}"
```

GIT commit with your message and push (⚠️ first add files using `git add`).

### `gull`

GIT fetch all origins, pull from current branch, update all submodules.

### `http-server`

```shell
http-server "${PORT || 8080}"
```

Run an HTTP server using `python3` in the current directory.

### `https-server`

```shell
https-server "${PORT || 8443}"
```

Run an HTTP server using `twistd` in the current directory.

The certificate/key will be generated the first time and saved under `~/.http-server`

### `nef2jpg`

Find all NEF in current directory and convert into JPG using all possibile CPUs in parallel.

### `npm-ver`

```shell
npm-ver "${VERSION}"
```

Bump the current NPM module using `patch`, `minor` or `major`, publish it and push all generated GIT tags.

### `tor-enable-proxy`

```shell
tor-enable-proxy "${INTERFACE || 'Wi-Fi'}"
```

Start `tor`, and set the SOCKS proxy on the selected interface to use it system-wide.

### `upgrade`

Upgrade `brew`, `brew cask`, `mas`.

### `what-branch`

Echo which branch you're in.

### `what-ip`

Echo your local IP.

## Aliases

### vscode

```
vsc code . Open the current folder in VS code
vsca dir code --add dir Add folder(s) to the last active window
vscd file file code --diff file file Compare two files with each other.
vscg file:line[:char] code --goto file:line[:char] Open a file at the path on the specified line and character position.
vscn code --new-window Force to open a new window.
vscr code --reuse-window Force to open a file or folder in the last active window.
vscw code --wait Wait for the files to be closed before returning.
vscu dir code --user-data-dir dir Specifies the directory that user data is kept in. Can be used to open multiple distinct instances of Code.
vsce dir code --extensions-dir dir Set the root path for extensions.
vscie id or vsix-path code --install-extension extension-id> or <extension-vsix-path Installs an extension.
vscue id or vsix-path code --uninstall-extension id or vsix-path Uninstalls an extension.
vscv code --verbose Print verbose output (implies --wait).
vscl level code --log level Log level to use. Default is 'info'. Allowed values are 'critical', 'error', 'warn', 'info', 'debug', 'trace', 'off'.
vsced code --disable-extensions Disable all installed extensions.
```

### copyfile

```
copyfile index.php
```

### common-aliases

```
l ls -lFh
la ls -lAFh
lr ls -tRFh
lt ls -ltFh
ll ls -l
ldot ls -ld .\*
lS ls -1FSsh
lart ls -1Fcart
lrt ls -1Fcrt
zshrc \$EDITOR ~/.zshrc
h history
p (processes for current user)
Alias to place at the end of command:
Alias Command
H | head
T | tail
G | grep
L | less
M | most
LL 2>&1 | less
CA 2>&1 | cat -A
NE 2> /dev/null
NUL > /dev/null 2>&1
P 2>&1| pygmentize -l pytb
```

### jsontools

```
pp_json pretty prints json
is_json returns true if valid json; false otherwise
urlencode_json returns a url encoded string for the given json
urldecode_json returns decoded json for the given url encoded string
```

### osx

```
tab Open the current directory in a new tab
ofd Open the current directory in a Finder window
pfd Return the path of the frontmost Finder window
pfs Return the current Finder selection
cdf cd to the current Finder directory
pushdf pushd to the current Finder directory
quick-look Quick-Look a specified file
man-preview Open a specified man page in Preview app
showfiles Show hidden files
hidefiles Hide the hidden files
itunes Control iTunes. User itunes -h for usage details
spotify Control Spotify and search by artist, album, track and etc.
```
