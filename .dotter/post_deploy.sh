#!/bin/bash

set -e

echo "Running post deploy script"

# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # adding brew to $PATH
    echo "Setting {{brew_home}} to PATH"
    echo "eval \$({{brew_home}}/bin/brew shellenv)" >> $HOME/.zshenv
    eval "$({{brew_home}}/bin/brew shellenv)"
fi

brew install gcc -q
brew install zsh-syntax-highlighting -q

#
if ! command -v fzf >/dev/null 2>&1; then
    echo "Installing fzf"
    brew install fzf -q
fi

if ! [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
    echo "Installing sdkman"
    curl -s "https://get.sdkman.io" | bash && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

if ! command -v cl >/dev/null 2>&1; then
    echo "Installing cl"
    brew tap rvigo/cl && brew install cl -q && cl config zsh-widget --install
fi

{{#if (eq os "mac")}}
    echo "Installing some utilities"
    brew install zsh # the brew version is updated
    brew install coreutils -q
    brew install gpg2 -q
    brew install --cask iterm2 -q
    brew install --cask visual-studio-code -q 
    brew install --cask intellij-idea-ce -q
    brew install --cask rectangle -q
{{/if}}