#!/bin/bash

#Script to build and serve a Flutter web application with HTTPS
#Ensure required packages are installed
#sudo npm install -g spdy live-server https://github.com/fishel-feng/live-server
#Usage:
#sh scripts/server_https.sh [param]
#Params:
#dev - Build the web application for development

set -e

CERT_DIR="./certs"
CONF_FILE="./https.conf.js"

# Get local IP address
LOCAL_IP=$(ipconfig getifaddr en0)
if [ -z "$LOCAL_IP" ]; then
    LOCAL_IP=$(ipconfig getifaddr en1)
fi

if [ -z "$LOCAL_IP" ]; then
    echo "❌ Failed to determine local IP address."
    exit 1
fi

echo "✅ Local IP address: $LOCAL_IP"

# Install mkcert if not installed
if ! command -v mkcert &> /dev/null; then
    echo "📦 Installing mkcert..."
    brew install mkcert
    mkcert -install
else
    echo "✅ mkcert is installed."
fi

# Create certs directory
mkdir -p "$CERT_DIR"


# Generate certificate
echo "🔐 Generating certificate for $LOCAL_IP..."
mkcert -cert-file "$CERT_DIR/cert.pem" -key-file "$CERT_DIR/cert-key.pem" "$LOCAL_IP"

# Create https.conf.js
echo "🛠️ Creating $CONF_FILE..."
cat > "$CONF_FILE" <<EOF
var fs = require("fs");

module.exports = {
  cert: fs.readFileSync(__dirname + "/certs/cert.pem"),
  key: fs.readFileSync(__dirname + "/certs/cert-key.pem"),
};
EOF


if [ "$1" = "dev" ]; then
    echo '=====================Develop====================='
    sh scripts/copy_firebase_config.sh dev
#    fvm flutter pub run build_runner build --delete-conflicting-outputs
    fvm flutter build web --debug -t lib/main_develop.dart
elif [ "$1" = "release" ]; then
    echo '=====================Release Dev====================='
    sh scripts/copy_firebase_config.sh dev
#    fvm flutter pub run build_runner build --delete-conflicting-outputs
    fvm flutter build web --release -t lib/main_develop.dart

fi

live-server \
            --https=./https.conf.js \
            --entry-file=index.html \
            --port=1234 \
            --host="$LOCAL_IP" \
               --mount=/:./\
               --verbose \
               --no-browser \
               --watch=none \
               --cors \
               --isolated \
               build/web
