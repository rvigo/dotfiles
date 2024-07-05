#!/bin/bash

set -e

echo "Building gitstatus binary"
GITSTATUS_DIR=$HOME/.dotfiles/zsh/plugins/git/gitstatus

cargo build --manifest-path $GITSTATUS_DIR/Cargo.toml --release
cp $GITSTATUS_DIR/target/release/gitstatus $HOME/.dotfiles/zsh/plugins/git/_gitstatus

echo "Done"