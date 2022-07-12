#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Update the debian variant and get some useful programs
sudo apt-get update && sudo apt-get dist-upgrade -y

sudo apt-get install -y git pass gpg tree vim htop curl wget gimp

# Rust or bust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo apt-get autoremove -y

