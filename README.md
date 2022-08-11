# Installations of some Tools
```
- brew install zsh
- brew install alacritty
- brew install tmux (in tmux.conf: type command: <C-a>I)
```

# Installing neovim from source:
## Installing dependencies first:
```
- brew install pkgconfig
- brew install cmake
- brew install autoconf && brew install automake
- brew install ripgrep
```

## Clone repo in $Home/ directory
```
- brew install zsh
- git clone https://github.com/neovim/neovim.git 
- git checkout release-0.7 // checkout version you want or main branch
- make CMAKE_BUILD_TYPE=Release
- sudo make install
- run nvim
```

# Installing nerdfonts
```
- brew tap homebrew/cask-fonts
- brew install --cask font-hack-nerd-font
```


# To install this neovim-config or unbreakable-ide
## Installing dependencies first:
```
- node & npm
```

## Clone one of those repos
```
- git clone https://github.com/LunarVim/nvim-basic-ide.git ~/.config/nvim

- git clone https://github.com/juridiener/dotfiles-config.git
  Clone whole config to ~/.config/ or extract only nvim and copy to ~/.config/

- run nvim
- If any errors then run: PackerSync
- :checkhealth
- If any errors on checkhealth then run: :TSUpdate
```

## Installing language-servers
Before or after cloning this repo if before doesn't work then installing first servers and then clone the nvim folder to ./config/
```
- npm i -g pyright
- npm i -g vscode-langservers-extracted
- npm i -g typescript typescript-language-server
- npm i -g vim-language-server
```



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

