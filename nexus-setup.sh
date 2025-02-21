#!/bin/bash

# Update package lists
sudo apt update -y

# Install required dependencies
sudo apt install -y build-essential gcc clang pkg-config libssl-dev git curl unzip

# Remove old protobuf compiler if installed
sudo apt remove -y protobuf-compiler || true

# Install latest Protobuf compiler (protoc v3.21.12)
PROTOC_ZIP=protoc-3.21.12-linux-x86_64.zip
wget -q https://github.com/protocolbuffers/protobuf/releases/download/v3.21.12/$PROTOC_ZIP
sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
sudo unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
rm -f $PROTOC_ZIP

# Verify installation
protoc --version

# Create and navigate to the working directory
mkdir -p nexus-cli && cd nexus-cli

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Add Rust target
rustup target add riscv32i-unknown-none-elf

# Upgrade Git
sudo apt upgrade -y git

# Install Nexus CLI
curl https://cli.nexus.xyz/ | sh

# Modify the build.rs file to enable `--experimental_allow_proto3_optional`
BUILD_RS_FILE="/root/.nexus/network-api/clients/cli/build.rs"
if [ -f "$BUILD_RS_FILE" ]; then
    sed -i 's/protoc_rust::Codegen::new()/protoc_rust::Codegen::new().customize(protoc_rust::Customize { experimental_allow_proto3_optional: true, ..Default::default() })/' "$BUILD_RS_FILE"
fi

# Clean and rebuild Nexus CLI
cd /root/.nexus/network-api/clients/cli
cargo clean
cargo build --release

echo "Nexus CLI installation completed successfully!"
