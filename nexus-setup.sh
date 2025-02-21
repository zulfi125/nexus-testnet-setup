#!/bin/bash

# Create and navigate to the directory
mkdir -p nexus-cli && cd nexus-cli

# Install Rust and set up the environment
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Add Rust target
rustup target add riscv32i-unknown-none-elf

# Update system packages
sudo apt update

# Install dependencies
sudo apt install -y pkg-config libssl-dev protobuf-compiler

# Install Nexus CLI
curl https://cli.nexus.xyz/ | sh

# Check for the proto3 optional error
if nexus-cli --version 2>&1 | grep -q "proto --experimental_allow_proto3_optional orchestrator.proto"; then
    echo "Error detected: proto3 optional issue. Fixing..."
    
    # Remove old protobuf compiler
    sudo apt-get remove -y protobuf-compiler

    # Download and install the latest version
    wget https://github.com/protocolbuffers/protobuf/releases/download/v30.0-rc1/protoc-30.0-rc-1-linux-x86_64.zip

    sudo unzip protoc-30.0-rc-1-linux-x86_64.zip -d /usr/local/
    sudo chmod +x /usr/local/bin/protoc

    # Reinstall Nexus CLI
    curl https://cli.nexus.xyz/ | sh

    echo "Fix applied successfully!"
else
    echo "Nexus CLI installed successfully without errors!"
fi
