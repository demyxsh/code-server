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
cp "$OPENLITESPEED_CONFIG"/bs.php "$OPENLITESPEED_ROOT"/web/app/mu-plugins

# Set Bedrock to debug mode
sed -i "s|WP_ENV=.*|WP_ENV=development|g" "$OPENLITESPEED_ROOT"/.env

code-server ${OPENLITESPEED_ROOT} --bind-addr=0.0.0.0:8081 --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry
