#!/bin/bash

# Update system packages
sudo apt update -y

# Install required dependencies
sudo apt install -y build-essential gcc clang pkg-config libssl-dev protobuf-compiler git

# Create and navigate to the working directory
mkdir -p nexus-cli && cd nexus-cli

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust target
source $HOME/.cargo/env
rustup target add riscv32i-unknown-none-elf

# Upgrade Git
sudo apt upgrade -y git

# Install Nexus CLI
curl https://cli.nexus.xyz/ | sh

echo "Nexus CLI installation completed successfully!"
