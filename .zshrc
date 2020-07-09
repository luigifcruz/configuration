export ZSH="/home/luigifcruz/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  sudo
  colored-man-pages
)

alias vim="nvim"
alias vi="nvim"

if [ "$TMUX" = "" ]; then tmux; fi

source $ZSH/oh-my-zsh.sh
