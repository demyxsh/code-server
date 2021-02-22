#!/usr/bin/dumb-init /bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Copy code directory/configs if it doesn't exist
if [[ ! -d /home/demyx/.code ]]; then
    cp -r "$CODE_CONFIG"/code /home/demyx/.code
fi

# Generate config
demyx-config

# Auto install WordPress if it's not installed already
demyx-install

# Install demyx helper plugin
cp "$CODE_CONFIG"/bs.php "$CODE_ROOT"/web/app/mu-plugins

# Configure xdebug
if [[ ! -d "$CODE_ROOT"/.vscode ]]; then
    install -d -m 0755 -o demyx -g demyx "$CODE_ROOT"/.vscode
    mv "$CODE_CONFIG"/launch.json "$CODE_ROOT"/.vscode
fi

# Set Bedrock to debug mode
sed -i "s|WP_ENV=.*|WP_ENV=development|g" "$CODE_ROOT"/.env

# Start php-fpm in the background
php-fpm -D

# Support for v2
if [[ "$(code-server --version | grep yaml || true)" ]]; then
    code-server ${CODE_ROOT} --bind-addr=0.0.0.0:8080 --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry
else
    code-server ${CODE_ROOT} --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry    
fi
