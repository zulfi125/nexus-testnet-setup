#!/bin/bash

# Update system packages
sudo apt update

# Install dependencies
sudo apt install -y pkg-config libssl-dev protobuf-compiler

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
