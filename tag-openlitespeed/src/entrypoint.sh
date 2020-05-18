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

# Install WordPress
demyx-install

# OpenLiteSpeed admin
demyx-admin

# OpenLiteSpeed htpasswd
demyx-htpasswd

# Start OLS
demyx-lsws

# Install demyx helper plugin
[[ ! -d "$OPENLITESPEED_ROOT"/wp-content/mu-plugins ]] && install -d -m 0755 -o demyx -g demyx "$OPENLITESPEED_ROOT"/wp-content/mu-plugins
cp "$OPENLITESPEED_CONFIG"/bs.php "$OPENLITESPEED_ROOT"/wp-content/mu-plugins

# Set wp-config.php to debug mode
sed -i "s|'WP_DEBUG', false|'WP_DEBUG', true|g" "$OPENLITESPEED_ROOT"/wp-config.php

code-server ${OPENLITESPEED_ROOT} --bind-addr=0.0.0.0:8081 --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry
