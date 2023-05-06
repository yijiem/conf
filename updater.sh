#!/bin/bash

# script to update this repo

err() {
  echo "$*" >&2
}

TMUX=~/.tmux.conf

dir=$(dirname "$0")

if [[ -e "${TMUX}" ]]; then
  cp "${TMUX}" "${dir}"
fi
git add "${dir}"/.tmux.conf

# add ourselves if modified
out=$(git status --porcelain | grep $(basename "$0") | grep M)
if (( $? == 0 )); then
  git add "$0"
fi

