#!/bin/bash
# Demyx
# https://demyx.sh

# Set default workdir
if [[ -z "$CODER_WORKDIR" ]]; then
    CODER_WORKDIR=/home/demyx
fi

# Execute command before starting up code-server
"$@"

code-server $(echo "$CODER_WORKDIR") --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry
