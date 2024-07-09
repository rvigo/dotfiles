#!/bin/bash

set -e

echo "Running pre deploy script"

# Check if Homebrew is installed
if ! command_exists "brew"; then
    echo "Homebrew is not installed, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # Adding brew to $PATH
    echo "Setting {{brew_home}} to PATH"
    echo "eval \$({{brew_home}}/bin/brew shellenv)" >> $HOME/.zshenv
    eval "$({{brew_home}}/bin/brew shellenv)"
fi

brew install --quiet gcc 

brew install --quiet zsh-syntax-highlighting 

#
if ! command_exists "fzf"; then
    echo "Installing fzf"
    brew install --quiet fzf 
fi

if ! command_exists "cl"; then
    echo "Installing cl"
    brew tap rvigo/cl && brew install --quiet cl # && cl config zsh-widget --install 
fi

{{#if (eq os "mac")}}
    echo "Installing some utilities"
    brew install --quiet zsh \
    coreutils \
    gpg2 

    brew install --cask --quiet iterm2 \
    visual-studio-code \
    intellij-idea-ce \
    rectangle
{{/if}}
