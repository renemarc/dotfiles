#!/bin/sh
# -*-mode:shell-*- vim:ft=sh

set -e

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

error() {
    echo ${RED}"Error: $@"${RESET} >&2
}

function setup_color() {
    # Only use colors if connected to a terminal
    if [ -t 1 ]; then
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        BOLD=$(printf '\033[1m')
        RESET=$(printf '\033[m')
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        RESET=""
    fi
}

function import_repo() {
    repo=$1
    destination=$2
    TMPFILE=$(mktemp /tmp/dotfiles.XXXXXXXXX_$(uuidgen).tar.gz) || exit 1
    curl -s -L -o "$TMPFILE" "$repo" || exit 1
    chezmoi import --strip-components 1 --destination "$destination" "$TMPFILE" || exit 1
    rm -f "$TMPFILE"
}

function setup_dependencies() {
    echo "\n${BOLD}Setting up dependencies:${RESET}\n"

    # Install Homebrew packages
    if command -v brew > /dev/null; then
        echo "${BLUE}Installing/updating apps using Homebrew...${RESET}"
        brew bundle --global
    fi
}

function setup_prompts() {
    echo "\n${BOLD}Setting up shell frameworks:${RESET}\n"

    # Install Bash-it
    PACKAGE_NAME='Bash-it'
    echo "${BLUE}Installing/updating ${PACKAGE_NAME}...${RESET}"
    import_repo 'https://github.com/Bash-it/bash-it/archive/master.tar.gz' "${HOME}/.bash-it" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install Oh My Zsh
    PACKAGE_NAME='Oh My Zsh'
    echo "${BLUE}Installing/updating ${PACKAGE_NAME}...${RESET}"
    import_repo 'https://github.com/robbyrussell/oh-my-zsh/archive/master.tar.gz' "${HOME}/.oh-my-zsh" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install Zsh plugins
    PACKAGE_NAME='zsh-autosuggestions'
    echo "${BLUE}Installing/updating Zsh plugin: ${PACKAGE_NAME}...${RESET}"
    import_repo 'https://github.com/zsh-users/zsh-autosuggestions/archive/master.tar.gz' "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    PACKAGE_NAME='zsh-syntax-highlighting'
    echo "${BLUE}Installing/updating Zsh plugin: ${PACKAGE_NAME}...${RESET}"
    import_repo 'https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz' "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install Zsh themes
    PACKAGE_NAME='Powerlevel9k'
    echo "${BLUE}Installing/updating Zsh theme: ${PACKAGE_NAME}...${RESET}"
    import_repo 'https://github.com/Powerlevel9k/powerlevel9k/archive/master.tar.gz' "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel9k" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    PACKAGE_NAME='Powerlevel10k'
    echo "${BLUE}Installing/updating Zsh theme: ${PACKAGE_NAME}...${RESET}"
    import_repo 'https://github.com/romkatv/powerlevel10k/archive/master.tar.gz' "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }
}

function setup_devtools() {
    echo "\n${BOLD}Setting up development tools:${RESET}\n"

    command_exists git || {
        error "git is not installed"
        exit 1
    }

    # Install NVM
    echo "${BLUE}Installing/updating Node Version Manager...${RESET}"
    export NVM_DIR="$HOME/.nvm" && (
        NVM_NEW=false
        if [ ! -d "$NVM_DIR" ]; then
            git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
            NVM_NEW=true
        fi
        cd "$NVM_DIR"
        if [ ! NVM_NEW ]; then
            git fetch --tags origin
        fi
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "$NVM_DIR/nvm.sh" && \. "$NVM_DIR/bash_completion"

    # Install Node.js
    echo "${BLUE}Installing/updating Node.js...${RESET}"
    nvm install node
}

function finalize_dotfiles() {
    echo "\n${BOLD}Finalizing dotfiles:${RESET}\n"

    echo "${BLUE}Updating dotfiles at destination...${RESET}"
    chezmoi apply
}

function main() {
    echo "\n${BOLD}Dotfiles setup script${RESET}"

    command_exists chezmoi || {
        error "chezmoi is not installed"
        exit 1
    }

    setup_dependencies
    setup_color
    setup_prompts
    setup_devtools
    finalize_dotfiles

    echo "\n${GREEN}Done!${RESET}\n"

    # if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    #    [ -s "$HOME/.zshrc" ] && \. "$HOME/.zshrc"
    # elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    #    [ -s "$HOME/.bashrc" ] && \. "$HOME/.bashrc"
    # fi
}

main "$@"
