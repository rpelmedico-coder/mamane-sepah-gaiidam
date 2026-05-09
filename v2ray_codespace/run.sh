#!/bin/bash

# This script downloads and starts Xray (VLESS over WebSocket) in GitHub Codespaces

PORT=8080

echo "[*] Preparing environment..."
mkdir -p xray

echo "[*] Checking dependencies (unzip)..."
if ! command -v unzip &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y unzip
fi

echo "[*] Downloading Xray-core..."
wget -qO xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip -o xray.zip -d xray
rm xray.zip
chmod +x xray/xray

echo "[*] Generating UUID..."
UUID=$(cat /proc/sys/kernel/random/uuid)

echo "[*] Creating VLESS config..."
cat <<EOF > xray/config.json
{
  "inbounds": [{
    "port": $PORT,
    "protocol": "vless",
    "settings": {
      "clients": [{ "id": "$UUID" }],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {
        "path": "/"
      }
    }
  }],
  "outbounds": [{
    "protocol": "freedom"
  }]
}
EOF

# Codespace domain for the forwarded port
DOMAIN="${CODESPACE_NAME}-${PORT}.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"

echo ""
echo "================================================================"
echo "      VLESS PROXY READY"
echo "================================================================"
echo "VLESS Link (Copy and import into v2rayNG / v2rayN):"
echo ""
echo "vless://${UUID}@${DOMAIN}:443?encryption=none&security=tls&type=ws&path=/#Codespace-Proxy"
echo ""
echo "================================================================"
echo "ATTENTION! - CRITICAL STEP"
echo "The proxy will NOT work unless the port is public."
echo "1. Go to the 'PORTS' tab (bottom panel, next to TERMINAL)."
echo "2. Right-click on port $PORT."
echo "3. Change 'Port Visibility' to 'Public'."
echo "================================================================"
echo "[*] Starting Xray server (Keep this tab open)..."
echo "================================================================"

# Try to automatically make the port public using GitHub CLI
if command -v gh &> /dev/null; then
    gh auth status &>/dev/null && gh codespace ports visibility $PORT:public -c $CODESPACE_NAME &>/dev/null
fi

./xray/xray -config xray/config.json
