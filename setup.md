# Awesome Links to discover:
https://github.com/rockerBOO/awesome-neovim
https://github.com/swaywm/sway
https://www.hammerspoon.org
https://github.com/peterklijn/hammerspoon-shiftit
https://github.com/maximbaz/dotfiles

Window Manager for macOS:
https://github.com/ianyh/Amethyst
https://github.com/Kintaro/wtftw

Yabai:
https://github.com/koekeishiya/yabai
https://www.reddit.com/r/MacOSBeta/comments/qtk1qy/how_to_install_yabai_window_manager_on_macos/
https://www.youtube.com/watch?v=JL1lz77YbUE
https://medium.com/@scr34mz/make-your-mac-keyboard-work-on-medium-and-others-editors-without-dead-keys-issues-french-keyboard-4666b72fa2ae

fzf Fuzzy Finder for Terminal
https://github.com/junegunn/fzf
https://github.com/sharkdp/fd
https://github.com/sharkdp/bat

---------------------------------------------------------

#Installing neovim from source on MacOS or Linux

Install dependencies:
- brew install pkgconfig
- brew install cmake
- brew install autoconf && brew install automake

## Clone repo in $Home/ for example
git clone https://github.com/neovim/neovim.git 
git checkout ... // checkout version which you want
make CMAKE_BUILD_TYPE=Release
sudo make install
run nvim
If any errors then run: PackerSync
:checkhealth
If any errors on checkhealth then : TSUpdate
:checkhealth
If any errors on checkhealth then : TSUpdate

----------------------------------------------------------

# Installations to setup lsp

 // https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

- npm i -g pyright
- npm i -g bash-language-server
- npm i -g vscode-langservers-extracted
- npm i -g graphql-language-service-cli
- npm i -g typescript typescript-language-server
- npm i -g vim-language-server
- yarn global add yaml-language-server


# Installation of tools
- brew install alacritty
- brew install zsh
  - chsh -s $(which zsh)
  # If at any point you decide you don’t like zsh, you can revert to Bash using: chsh -s $(which bash)

- Install ohmyzsh
  - sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  - create custom .zshrc under ~/.config/zsh/.zshrc
  - add .zshenv - file under ~/.zshenv
    - ZDOTDIR=~/.config/zsh/

- brew install tree
  - to list files and directories in a tree structure

- brew install php

To install nerd font hack
- brew tap homebrew/cask-fonts
- brew install --cask font-hack-nerd-font

Install tmux
- brew install tmux
in tmux.conf: type command: <C-a>I


Install window manager:
https://github.com/fikovnik/ShiftIt

# For managing dotfiles:
- git init --bare $HOME/dotfiles


# brew update
## list outdated plugins
- brew outdated
## upgrade plugins
- brew upgrade


# exit fullscreen in alacritty
The default macOS binding to toggle fullscreen is Ctrl + Command + F.


Not installed:
- php // https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#phpactor
- lua // https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua

#Rails Commands 

## Empty a table, delete all records in a table
Use Antraege.delete_all
https://dev.to/asyraf/deleting-all-data-from-a-table-in-ruby-on-rails-39he

rails c 
Antraege.delete_all

## Add a Model with references to another table 
rails g model modelname_to_create modelname_for_reference fieldname:datatype
Example: rails g model antraege mitarbeiter:references name:string kommentar:string

## Execute a task under lib/tasks
bundle exec rake namespace:method_name
Example: bundle exec rake query:import


# Tmux Commands
  - tmux detach 
    - detach the session but doesn't kill it
  - Save session
    - prefix + ctrl + s

# GIT Commands

  git log --author=Juri 
    - logs all commits from spesific user
  git log --stat --author=Juri  > ./redesign.log
    - logs commits to a file
  git log -p 
    - logs the content to

## Logs the difference commits remote and local
    logs the commits from remote branch to check which commits remote but not local
      git log HEAD..origin/master
    logs the commits from local branch to check which commits are local but not in remote
      git log origin/master..HEAD

## show all commits
  git reflog

# Bash Commands
  nvim **/*.html
    - open all files in current and sub directories 

  mkdir -p foo/bar/baz
    - create folders -p if not exist

  cp file1 /dir/
  for i in ~/folder1 ~/folder2; do cp  ~/test.txt $i; done 
    - copy file to multiple dirs
  To copy whole directories you have to use the -r option:
    - for i in ~/folder1 ~/folder2; do cp -r ~/folder3 $i; done

  Move file to dir
  mv /home/jack/testfile /home/jack/testfile2

  Search text in files/directories:
  -r or -R is recursive,
  -n is line number, and
  -w stands for match the whole word.
  -l (lower-case L) can be added to just give the file name of matching files.
  -e is the pattern used during the search

  Examples:
  - This will only search through those files which have .c or .h extensions:
    - grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"
  - This will exclude searching all the files ending with .o extension:
    - grep --exclude=\*.o -rnw '/path/to/somewhere/' -e "pattern"

