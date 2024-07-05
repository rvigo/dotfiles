#!/bin/bash

set -e

echo "Building gitstatus binary"
GITSTATUS_DIR=$HOME/.dotfiles/zsh/plugins/git/gitstatus

echo "Checking dirs"
if [ ! -d $GITSTATUS_DIR ]; then
    echo "Directory $GITSTATUS_DIR does not exist"
    exit 1
fi
ls $GITSTATUS_DIR
echo ++++   

cargo build --manifest-path $GITSTATUS_DIR/Cargo.toml --release
cp $GITSTATUS_DIR/target/release/gitstatus $HOME/.dotfiles/zsh/plugins/git/_gitstatus

echo "Done"