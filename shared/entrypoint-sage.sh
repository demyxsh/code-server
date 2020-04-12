#!/usr/bin/dumb-init /bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

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

code-server ${CODE_ROOT} --host=0.0.0.0 --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry --disable-updates --disable-ssh --port=8080
