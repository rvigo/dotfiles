#!/bin/sh

# Check if Homebrew is installed
if ! [ -x "$(command -v brew)" ]; then
    echo "Homebrew is not installed, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    brew_prefix=/opt/homebrew
    {{#if (eq os "ubuntu")}}
    brew_prefix=/home/linuxbrew/.linuxbrew
    {{/if}}

    # adding brew to $PATH
    echo "Setting $brew_prefix to PATH"
    (echo; echo 'eval "$($brew_prefix/bin/brew shellenv)"') >> ~/.profile
    eval "$($brew_prefix/bin/brew shellenv)"
fi

# installing recomendation
if ! [ -x "$(command -v gcc)" ]; then
    echo "Installing recomendations"
    brew install gcc -q
fi

# Install fzf, sdkman, and rvigo/cl
if ! [ -x "$(command -v fzf)" ]; then
    echo "Installing fzf"
    brew install fzf -q
fi
# echo "Installing nvim"
# brew install nvim

if ! [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
    echo "Installing sdkman"
    curl -s "https://get.sdkman.io" | bash && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

if ! [ -x "$(command -v cl)" ]; then
    echo "Installing cl"
    brew tap rvigo/cl && brew install cl -q
fi
