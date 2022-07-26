#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

mkdir -p ~/build
pushd ~/build

rm -rf neovim
git clone https://github.com/neovim/neovim

pushd neovim
git checkout stable

make CMAKE_BUILD_TYPE=Release
sudo make install

popd && popd
