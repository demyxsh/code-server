#!/bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Compatibility with old paths
[[ -d /var/www/html/wp-admin ]] && CODE_SERVER_ROOT=/var/www/html

# Generate config
demyx-config

# Auto install WordPress if it's not installed already
demyx-install

# Install demyx helper plugin
cp "$CODE_SERVER_CONFIG"/bs.php "$CODE_SERVER_ROOT"/web/app/mu-plugins

# Set prefix
CODE_SERVER_BASE_PREFIX=${CODE_SERVER_BASE_PREFIX:-/cs}
[[ "$CODE_SERVER_BASE_PREFIX" = false ]] && CODE_SERVER_BASE_PREFIX=

# Set base path
CODE_SERVER_BASE_PATH="${CODE_SERVER_BASE_PATH:-/demyx}"
[[ "$CODE_SERVER_BASE_PATH" = false ]] && CODE_SERVER_BASE_PATH=

# Configure xdebug
if [[ ! -d "$CODE_SERVER_ROOT"/.vscode ]]; then
    install -d -m 0755 -o demyx -g demyx "$CODE_SERVER_ROOT"/.vscode
    mv "$CODE_SERVER_CONFIG"/launch.json "$CODE_SERVER_ROOT"/.vscode
fi

# Set Bedrock to debug mode
sed -i "s|WP_ENV=.*|WP_ENV=development|g" "$CODE_SERVER_ROOT"/.env

# Start php-fpm in the background
php-fpm -D

code-server ${CODE_SERVER_ROOT} --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry --base-path="${CODE_SERVER_BASE_PATH}${CODE_SERVER_BASE_PREFIX}"
