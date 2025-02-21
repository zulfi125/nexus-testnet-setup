#!/bin/bash

# Update system packages
sudo apt update

# Install required dependencies
sudo apt install -y build-essential gcc g++ make cmake pkg-config libssl-dev protobuf-compiler

# Remove existing protobuf-compiler (if any)
sudo apt-get remove -y protobuf-compiler

# Download and install the latest Protocol Buffers (protobuf)
wget https://github.com/protocolbuffers/protobuf/releases/download/v30.0-rc1/protoc-30.0-rc-1-linux-x86_64.zip
sudo unzip protoc-30.0-rc-1-linux-x86_64.zip -d /usr/local/
sudo chmod +x /usr/local/bin/protoc

# Create and navigate to the nexus-cli directory
mkdir -p nexus-cli
cd nexus-cli

# Install Rust and set up the environment
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Add Rust target for riscv32i
rustup target add riscv32i-unknown-none-elf

# Upgrade Git
sudo apt upgrade -y git

# Install Nexus CLI
curl https://cli.nexus.xyz/ | sh

# Verify installation
rustc --version
cargo --version
gcc --version
which cc
