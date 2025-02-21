#!/bin/bash

set -e  # Exit script if any command fails

# Create and navigate to nexus-cli directory
mkdir -p nexus-cli
cd nexus-cli

# Install required build tools
sudo apt update
sudo apt install -y build-essential pkg-config libssl-dev protobuf-compiler gcc

# Install Rust and required target
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup target add riscv32i-unknown-none-elf

# Install Nexus CLI
curl https://cli.nexus.xyz/ | sh

# Function to fix protobuf issue
fix_protobuf() {
    sudo apt-get remove -y protobuf-compiler
    wget https://github.com/protocolbuffers/protobuf/releases/download/v30.0-rc1/protoc-30.0-rc-1-linux-x86_64.zip
    sudo unzip protoc-30.0-rc-1-linux-x86_64.zip -d /usr/local/
    sudo chmod +x /usr/local/bin/protoc
    echo "Protobuf issue fixed."
}

# Function to restart Nexus CLI
restart_nexus() {
    curl https://cli.nexus.xyz/ | sh
    echo "Nexus CLI restarted."
}

# Check if protobuf issue occurs and fix it if needed
if protoc --version 2>&1 | grep -q "experimental_allow_proto3_optional"; then
    fix_protobuf
fi

echo "Nexus CLI setup completed. Get Node ID from: https://beta.nexus.xyz/"
