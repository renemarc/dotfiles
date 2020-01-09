#!/bin/bash
# -*-mode:bash-*- vim:ft=bash

# Install NVM
export NVM_DIR="$HOME/.nvm" && (
  if [[ ! -d "$NVM_DIR" ]]; then
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  fi
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh" && \. "$NVM_DIR/bash_completion"

# Install Node
nvm install node
