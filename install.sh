#!/bin/sh

set -u

DOTPATH=$(cd $(dirname $0) && pwd)

# Creating symbolic links
for dotfile in .??*; do
  [ "$dotfile" = ".git" ] && continue
  [ "$dotfile" = ".gitignore" ] && continue
  [ "$dotfile" = ".config" ] && continue

  ln -nsfv "$DOTPATH"/"$dotfile" "$HOME"/"$dotfile"
done

# .config
for dotfile in `ls -1 .config`; do
  ln -nsfv "$DOTPATH"/.config/"$dotfile" "$HOME"/.config/"$dotfile"
done
