#!/bin/bash

echo "🚀 Installing Nexus CLI..."
curl https://cli.nexus.xyz/ | sh

# Prompt for Prover ID
read -p "Enter your Prover ID: " PROVER_ID
export NEXUS_PROVER_ID=$PROVER_ID

echo "⚙️ Starting Nexus Service..."
sudo systemctl start nexus.service

echo "📜 Viewing Logs (Last 50 lines)..."
journalctl -u nexus.service -f -n 50
