#!/bin/sh

set -u

DOTPATH=$(cd $(dirname $0) && pwd)
DEINPATH="$DOTPATH"/.cache/dein/repos/github.com/Shougo/dein.vim

ln -nsfv "$DOTPATH/.config/nvim" "$HOME/.config/nvim"

# Creating symbolic links
for dotfile in .??*; do
  [ "$dotfile" = ".git" ] && continue
  [ "$dotfile" = ".gitignore" ] && continue
  [ "$dotfile" = ".config" ] && continue

  ln -nsfv "$DOTPATH"/"$dotfile" "$HOME"/"$dotfile"
done


# Installing dein.vim
[ ! -d "$DEINPATH" ] && git clone https://github.com/Shougo/dein.vim.git "$DEINPATH"
