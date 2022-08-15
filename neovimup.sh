#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

sudo apt-get update
sudo apt-get install ninja-build gettext libtool libtool-bin \
    autoconf automake cmake g++ pkg-config unzip curl doxygen

pushd /tmp

rm -rf neovim
git clone https://github.com/neovim/neovim

pushd neovim
git checkout stable

make CMAKE_BUILD_TYPE=Release
sudo make install

popd
rm -rf neovim
popd

