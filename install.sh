#!/bin/bash
# shellcheck disable=SC1091

set -e

source ./.dotter/utils.sh

DOTFILES_DIR="$HOME/.dotfiles"
DOTTER_CONFIG_FOLDER="$DOTFILES_DIR/.dotter/include"
OS=$(uname -s)

install_rust() {
    if ! command_exists "rustc"; then
        echo "Rust is not installed. Installing from the official website..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y

        source "$HOME/.cargo/env"
        echo "Rust has been installed."
    else
        echo "Rust is already installed."
    fi
}

install_dotter() {
    echo "Installing dotter"
    if ! command_exists "dotter"; then
        cargo install dotter --quiet
        echo "dotter has been installed."
    else
        echo "dotter is already installed."
    fi
}

clone_repo() {
# if [ -n "$CI" ] && [ "$(pwd)" != "$HOME" ]; then
#     echo "moving everything to $DOTFILES_DIR"
#     mkdir -p "$DOTFILES_DIR"
   
#     shopt -s dotglob
#     mv $(pwd)/* "$DOTFILES_DIR" 
# fi
    if [ ! -n "$CI" ];then
        if [ ! -d "$DOTFILES_DIR" ]; then
            echo "Cloning rvigo/dotfiles to $DOTFILES_DIR ..."
            git clone https://github.com/rvigo/dotfiles.git "$DOTFILES_DIR"
        else
            echo "The $DOTFILES_DIR directory already exists. Skipping clone."
        fi
    else 
        echo "Skipping repo clone step (running in a CI env)"
    fi
}

select_os() {
    if [ "$OS" = "Linux" ]; then
        DOTTER_CONFIG="local.ubuntu.toml" 
        update_ubuntu
        set_zsh_as_default

    elif [ "$OS" == "Darwin" ]; then
        DOTTER_CONFIG="local.mac.toml"
    else
        echo "Unsupported operating system: $OS"
        exit 1
    fi
}

update_ubuntu() {
    echo "Updating some packages"
    if [ -n "$CI" ]; then
        DF="DEBIAN_FRONTEND=noninteractive "
    fi

    DF+="apt-get -qq install build-essential git-all zsh -yq"  
    eval "apt-get -qq update && $DF"
}

set_zsh_as_default() {
    echo "Setting 'zsh' as default shell"
    chsh -s "$(which zsh)"
}

run_dotter() {
    echo "Running dotter..."
    if [ -n "$CI" ]; then
        dotter -l ./.dotter/$DOTTER_CONFIG --force
    else
        dotter -l $DOTTER_CONFIG_FOLDER/$DOTTER_CONFIG --force
    fi
}

install_rust
install_dotter
clone_repo

select_os

run_dotter