#!/bin/bash
echo "📜 Viewing Nexus Logs..."
journalctl -u nexus.service -f -n 50
