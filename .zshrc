export ZSH="/home/luigi/.oh-my-zsh"
export TERM=xterm-256color

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

PATH=$PATH:/opt/Xilinx/Vivado/2021.1/bin
