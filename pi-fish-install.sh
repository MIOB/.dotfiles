#!/bin/bash

set -e

FISH_VERSION="3.3.1"

sudo apt update
sudo apt install build-essential cmake ncurses-dev libncurses5-dev libpcre2-dev gettext

FISH_TMP_DIR=$(mktemp --directory) 
pushd "$FISH_TMP_DIR"

wget "https://github.com/fish-shell/fish-shell/releases/download/$FISH_VERSION/fish-$FISH_VERSION.tar.xz"
tar --extract --xz --preserve-permissions --file fish-$FISH_VERSION.tar.xz
cd "fish-$FISH_VERSION"

cmake .
make
sudo make install

echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

popd
rm -rf "$FISH_TMP_DIR"
