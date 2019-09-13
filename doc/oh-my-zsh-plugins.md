# vscode

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
```

```
vscv code --verbose Print verbose output (implies --wait).
vscl level code --log level Log level to use. Default is 'info'. Allowed values are 'critical', 'error', 'warn', 'info', 'debug', 'trace', 'off'.
vsced code --disable-extensions Disable all installed extensions.
```

# sudo

ESC twice: Puts sudo in front of the current command, or the last one if the command line is empty.

# docker

Auto complete arguments and options for all docker commands.

Show containerIDs and Images for tab completion where applicable (screenshots)

# copyfile

Copies content of a file into clipboard

copyfile index.php

# common-aliases

Collection of useful zsh aliases, not enabled by default since they may change some user defined aliases.
Alias Command
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

# last-working-dir

Keeps track of the last used directory and automatically jumps to it for new shells.
Similar to how many terminal emulators does it.

# jsontools

pp_json pretty prints json
is_json returns true if valid json; false otherwise
urlencode_json returns a url encoded string for the given json
urldecode_json returns decoded json for the given url encoded string

# osx

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

# gitfast

Enables the zsh completion from git.git folks, which is much faster than the official one from zsh.
A lot of zsh-specific features are not supported, like descriptions for every argument, but everything the bash completion has, this one does too (as it is using it behind the scenes).
Not only is it faster, it should be more robust, and updated regularly to the latest git upstream version.

# git-extras

git changelog [-l/--list] populate changelog file with commits since the previous tag
git contrib display author contributions
git count [--all] count commits
git delete-branch delete local and remote branch
git delete-submodule delete submodule
git delete-tag delete local and remote tag
git extras [-v/--version] git-extras
git graft merge commits from source branch to destination branch
git squash merge commits from source branch into the current one as a single commit
git feature [finish] create a feature branch
git refactor [finish] create a refactor branch
git bug [finish] create a bug branch
git summary repository summary
git effort [--above] display effort statistics
git repl read-eval-print-loop
git commits-since list commits since a given date
git release release commit with the given tag
git alias define, search and show aliases
git ignore add patterns to .gitignore
git info show info about the repository
git create-branch create local and remote branch
git fresh-branch create empty local branch
git undo remove the latest commit
git setup setup a git repository
git touch one step creation of new files
git obliterate Completely remove a file from the repository, including past commits and tags
git local-commits list unpushed commits on the local branch
