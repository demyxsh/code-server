#!/bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Copy code directory/configs if it doesn't exist
if [[ ! -d /home/demyx/.code ]]; then
    cp -r "$CODE_CONFIG"/code /home/demyx/.code
fi

# TEMPORARY CODE
# Replace symbolic link
if [[ -n "$(stat /home/demyx/.zshrc | grep symbolic || true)" ]]; then
    rm -f /home/demyx/.zshrc
    cp "$CODE_CONFIG"/.zshrc /home/demyx
fi

# Start code-server
code-server /home/demyx --bind-addr=0.0.0.0:8080 --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry
