#!/bin/bash

export GOPATH="$HOME/ghq"
export GOBIN="$HOME/ghq/bin"
export PATH="$PATH:$GOBIN"

alias g='cd $(ghq root)/$(ghq list | peco)'
alias h='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias fcd='cd $(find . -type d | fzf)'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(rbenv init -)"
