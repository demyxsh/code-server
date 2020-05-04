#!/usr/bin/dumb-init /bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Generate config
demyx-config

# Auto install WordPress if it's not installed already
demyx-install

# Install demyx helper plugin
[[ ! -d "$CODE_ROOT"/wp-content/mu-plugins ]] && install -d -m 0755 -o demyx -g demyx "$CODE_ROOT"/wp-content/mu-plugins
cp "$CODE_CONFIG"/bs.php "$CODE_ROOT"/wp-content/mu-plugins

# Configure xdebug
if [[ ! -d "$CODE_ROOT"/.vscode ]]; then
    install -d -m 0755 -o demyx -g demyx "$CODE_ROOT"/.vscode
    mv "$CODE_CONFIG"/launch.json "$CODE_ROOT"/.vscode
fi

# Set wp-config.php to debug mode
sed -i "s|'WP_DEBUG', false|'WP_DEBUG', true|g" "$CODE_ROOT"/wp-config.php

# Start php-fpm in the background
php-fpm -D

# Support for v2
if [[ "$(code-server --version | grep info || true)" ]]; then
    code-server ${CODE_ROOT} --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry --base-path=/demyx/cs
else
    code-server ${CODE_ROOT} --bind-addr=0.0.0.0:8080 --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry --disable-updates --port=8080
fi
