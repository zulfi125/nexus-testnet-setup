#!/bin/bash

echo "Updating system packages..."
sudo apt update

echo "Installing required dependencies..."
sudo apt install -y build-essential gcc g++ make cmake pkg-config libssl-dev protobuf-compiler

echo "Ensuring 'cc' is properly linked..."
sudo ln -sf /usr/bin/gcc /usr/bin/cc

echo "Removing any existing protobuf-compiler..."
sudo apt-get remove -y protobuf-compiler

echo "Downloading and installing latest Protocol Buffers (protobuf)..."
wget https://github.com/protocolbuffers/protobuf/releases/download/v30.0-rc1/protoc-30.0-rc-1-linux-x86_64.zip
sudo unzip protoc-30.0-rc-1-linux-x86_64.zip -d /usr/local/
sudo chmod +x /usr/local/bin/protoc

echo "Creating Nexus CLI directory..."
mkdir -p nexus-cli
cd nexus-cli

echo "Installing Rust and setting up environment..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

echo "Adding Rust target for riscv32i..."
rustup target add riscv32i-unknown-none-elf

echo "Setting compiler environment variables..."
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
echo 'export CC=/usr/bin/gcc' >> ~/.bashrc
echo 'export CXX=/usr/bin/g++' >> ~/.bashrc
source ~/.bashrc

echo "Upgrading Git..."
sudo apt upgrade -y git

echo "Installing Nexus CLI..."
curl https://cli.nexus.xyz/ | sh

echo "Verifying installations..."
gcc --version
which cc
rustc --version
cargo --version

echo "Installation completed successfully!"
