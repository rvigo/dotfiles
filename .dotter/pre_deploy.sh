#!/bin/sh

# Check if Homebrew is installed
if ! command -v brew > /dev/null 2>&1
then
    echo "Homebrew is not installed, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install fzf, sdkman, and rvigo/cl
echo "Installing fzf"
brew install fzf

echo "Installing nvim"
brew install nvim

echo "Installing sdkman"
brew tap sdkman/tap
brew install sdkman

echo "Installing cl"
brew tap rvigo/cl
brew install cl