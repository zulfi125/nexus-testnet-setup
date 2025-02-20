#!/bin/bash

# Update system and install dependencies
sudo apt update && sudo apt install -y curl

# Install Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Add the riscv32i target
echo "Adding riscv32i target..."
rustup target add riscv32i-unknown-none-elf

# Install Nexus CLI
echo "Installing Nexus CLI..."
curl https://cli.nexus.xyz/ | sh

# Create a script to run the node with logging
echo "Creating run script..."
cat <<EOL > $HOME/run_nexus.sh
#!/bin/bash
LOGFILE="\$HOME/nexus_node.log"
echo "Starting Nexus node..."
cli-nexus > "\$LOGFILE" 2>&1 &
echo "Nexus node started with PID \$!"
EOL

# Make the script executable
chmod +x $HOME/run_nexus.sh

# Output instructions
echo "Installation complete."
echo "Run the node using: ~/run_nexus.sh"
echo "Check logs using: tail -f ~/nexus_node.log"
