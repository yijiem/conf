#!/bin/bash

# script to install this repo

TMUX=~/.tmux.conf

dir=$(dirname "$0")

if [[ -e "${TMUX}" ]]; then
  # warn for content diff
  d=$(diff "${TMUX}" "${dir}"/.tmux.conf)
  if [[ -n "${d}" ]]; then
    echo "WARNING: tmux conf differ:"
    echo "${d}"
    read -p "Continue install? [y/n] " response
    if [[ "${response}" == "n" ]]; then
      exit 0
    fi
  fi
fi

cp "${dir}"/.tmux.conf "${TMUX}"

# add ourselves if modified
out=$(git status --porcelain | grep $(basename "$0") | grep M)
if (( $? == 0 )); then
  git add "$0"
fi

