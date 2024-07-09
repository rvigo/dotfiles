#!/bin/bash
# shellcheck disable=SC1091

set -e

command_exists() {
    if command -v "$1" >/dev/null 2>&1; then
        return 0  # Command exists
    else
        return 1  # Command does not exist
    fi
}

DOTFILES_DIR="$HOME/.dotfiles"
DOTTER_CONFIG_FOLDER="$DOTFILES_DIR/.dotter"
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
        cargo install dotter 
        echo "dotter has been installed."
    else
        echo "dotter is already installed."
    fi
}

clone_repo() {
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo "Cloning rvigo/dotfiles to $DOTFILES_DIR ..."
        git clone https://github.com/rvigo/dotfiles.git "$DOTFILES_DIR"
    else
        echo "The $DOTFILES_DIR directory already exists. Skipping clone."
    fi
}

select_os() {
    if [ "$OS" = "Linux" ]; then
        DOTTER_CONFIG="local.ubuntu.toml" 
    elif [ "$OS" == "Darwin" ]; then
        DOTTER_CONFIG="local.mac.toml"
    else
        echo "Unsupported operating system: $OS"
        exit 1
    fi

    echo "Selected OS: $OS"
}

run_dotter() {
    echo "Running dotter..."
    echo "config: $DOTTER_CONFIG_FOLDER/$DOTTER_CONFIG"
    dotter -l "$DOTTER_CONFIG_FOLDER"/"$DOTTER_CONFIG" --force
}

clone_repo
install_rust
install_dotter

select_os

run_dotter