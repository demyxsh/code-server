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
cp "$OPENLITESPEED_CONFIG"/bs.php "$OPENLITESPEED_ROOT"/web/app/mu-plugins

# Set prefix
CODE_SERVER_BASE_PREFIX=${CODE_SERVER_BASE_PREFIX:-/cs}
[[ "$CODE_SERVER_BASE_PREFIX" = false ]] && CODE_SERVER_BASE_PREFIX=

# Set base path
CODE_SERVER_BASE_PATH="${CODE_SERVER_BASE_PATH:-/demyx}"
[[ "$CODE_SERVER_BASE_PATH" = false ]] && CODE_SERVER_BASE_PATH=

# Activate extension
OPENLITESPEED_CS_EXTENSION="$(find /etc/demyx -name "cjhowe7*")"
ln -sf "$OPENLITESPEED_CS_EXTENSION" /home/demyx/.code/extensions

# Set Bedrock to debug mode
sed -i "s|WP_ENV=.*|WP_ENV=development|g" "$OPENLITESPEED_ROOT"/.env

code-server ${OPENLITESPEED_ROOT} --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry --base-path="${CODE_SERVER_BASE_PATH}${CODE_SERVER_BASE_PREFIX}" --port=8081
