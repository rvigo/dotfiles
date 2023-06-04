#!/bin/bash

if ! command -v rustc >/dev/null 2>&1; then
    echo "Rust is not installed. Installing Rust from the official website..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    echo "Rust has been installed."
else
    echo "Rust is already installed."
fi

echo "Installing dotter"
if ! command -v dotter >/dev/null 2>&1;
then
    cargo install dotter
    echo "dotter has been installed."
else
    echo "dotter is already installed."
fi

if [ ! -d "$HOME/.dotfiles" ]
then
    echo "Cloning rvigo/dotfiles to ~/.dotfiles..."
    git clone https://github.com/rvigo/dotfiles.git "$HOME/.dotfiles"
else
    echo "The ~/.dotfiles directory already exists. Skipping clone."
fi

cd "$HOME/.dotfiles"
echo "Running dotter..."

OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    os="local.ubuntu.toml" 
elif [ "$OS" == "Darwin" ]; then
    os="local.mac.toml"
fi

dotter -l .dotter/$os