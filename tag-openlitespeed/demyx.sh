#!/bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

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

# Set prefix
CODE_SERVER_BASE_PREFIX=${CODE_SERVER_BASE_PREFIX:-/cs}
[[ "$CODE_SERVER_BASE_PREFIX" = false ]] && CODE_SERVER_BASE_PREFIX=

# Set base path
CODE_SERVER_BASE_PATH="${CODE_SERVER_BASE_PATH:-/demyx}"
[[ "$CODE_SERVER_BASE_PATH" = false ]] && CODE_SERVER_BASE_PATH=

# Set wp-config.php to debug mode
sed -i "s|'WP_DEBUG', false|'WP_DEBUG', true|g" "$OPENLITESPEED_ROOT"/wp-config.php

code-server ${OPENLITESPEED_ROOT} --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry --base-path="${CODE_SERVER_BASE_PATH}${CODE_SERVER_BASE_PREFIX}" --port=8081
