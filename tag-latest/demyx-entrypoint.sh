#!/bin/bash
# Demyx
# https://demyx.sh

# Enable/disable password authentication
if [[ "$CODER_AUTH" = false ]]; then
    CODER_AUTH_FLAG=
else
    CODER_AUTH_FLAG="--auth=password"
fi

# Set default workdir
if [[ -z "$CODER_WORKDIR" ]]; then
    CODER_WORKDIR=/home/demyx
fi

code-server $(echo "$CODER_WORKDIR") --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry "$CODER_AUTH_FLAG"
