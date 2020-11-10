export ZSH="/home/luigi/.oh-my-zsh"

ZSH_THEME="robbyrussell"

alias xclip="xclip -selection c"
alias vim="nvim"
alias vi="nvim"

plugins=(
  git
  sudo
  colored-man-pages
)

if [ "$TMUX" = "" ]; then tmux; fi

source $ZSH/oh-my-zsh.sh
