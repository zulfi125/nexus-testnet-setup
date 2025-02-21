#!/bin/bash

# Update system packages
sudo apt update

# Install dependencies
sudo apt install -y pkg-config libssl-dev protobuf-compiler

# Download and install the latest Protocol Buffers (protobuf)
wget https://github.com/protocolbuffers/protobuf/releases/download/v30.0-rc1/protoc-30.0-rc-1-linux-x86_64.zip
sudo unzip protoc-30.0-rc-1-linux-x86_64.zip -d /usr/local/
sudo chmod +x /usr/local/bin/protoc

# Create and navigate to the nexus-cli directory
mkdir -p nexus-cli
cd nexus-cli

# Install Rust and set up environment
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Add Rust target for riscv32i
rustup target add riscv32i-unknown-none-elf

# Upgrade Git
sudo apt upgrade -y git

# Install Nexus CLI
curl https://cli.nexus.xyz/ | sh
