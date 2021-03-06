alias ls='ls -vG'
alias ll='ls -vGla'
alias grep='grep --color'

export LSCOLORS="ExGxcxdxbxegedabagacad"

. ~/fancy-prompt.sh

ulimit -c unlimited
export TPU_NAME=btpu

export WORKON_HOME=$HOME/.virtualenvs
export MSYS_HOME=/c/msys/1.0
source /usr/local/bin/virtualenvwrapper.sh
