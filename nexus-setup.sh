#!/bin/bash

# Exit on error
set -e

# Update system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install required dependencies
echo "Installing dependencies..."
sudo apt install -y pkg-config libssl-dev protobuf-compiler build-essential curl gcc git

# Create and navigate to the nexus-cli directory
echo "Setting up Nexus CLI directory..."
mkdir -p $HOME/nexus-cli
cd $HOME/nexus-cli

# Install Rust and set up environment
if ! command -v rustc &> /dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
else
    echo "Rust is already installed."
fi

# Ensure Rust environment is loaded
export PATH="$HOME/.cargo/bin:$PATH"

# Add Rust target for riscv32i
echo "Adding Rust target for riscv32i..."
rustup target add riscv32i-unknown-none-elf

# Install Nexus CLI
echo "Installing Nexus CLI..."
curl -sSL https://cli.nexus.xyz/ | sh

# Verify installation
echo "Verifying Nexus CLI installation..."
if command -v nexus &> /dev/null; then
    echo "Nexus CLI installed successfully!"
    nexus --version
else
    echo "Nexus CLI installation failed!"
    exit 1
fi

echo "Setup completed successfully."
