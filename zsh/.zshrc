source ~/aliases.sh
fpath+=("$(brew --prefix)/share/zsh/site-functions")
export NX_DAEMON=false

# Path to your oh-my-zsh installation.
export ZSH="/Users/juri.diener/.oh-my-zsh"
export LANG=en_US.UTF-8

export TERM=screen-256color

ZSH_THEME="robbyrussell"

# open all files in neovim that are not staged and modified
alias nvim-gitdiff='nvim $(git diff --name-only)'
# goes to directory where git repo is initialized
alias cdg='cd $(git rev-parse --show-cdup)'

# switch to different nvim configs
alias nvim='NVIM_APPNAME=LazyVim nvim'
alias nvim-my='NVIM_APPNAME=nvim nvim'

alias aider='aider --model ollama/llama3.1'
alias aider-dsc='aider --model ollama/deepseek-coder-v2'

alias emacs-doom='open -a Emacs .'
# alias emacskick='emacs --init-directory ~/.config/emacs/kick-start/ &'
# alias emacsdoom='DOOMDIR=~/.config/emacs/doom emacs &'

# start docker dev compose file
alias dc-dev='docker compose -f docker-compose.yml -f docker-compose.dev.yml'

plugins=(git)

source $ZSH/oh-my-zsh.sh


export PATH="/usr/local/opt/ruby/bin:$PATH"
export OLLAMA_API_BASE="http://localhost:11434"
export PATH="$HOME/.emacs.d/bin:$PATH"

