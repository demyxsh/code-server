#!/bin/bash
# Demyx
# https://demyx.sh

# Enable/disable password authentication
if [[ "$CODER_AUTH" = false ]]; then
    CODER_AUTH_FLAG=
else
    CODER_AUTH_FLAG="--auth=password"
fi

code-server /home/coder --user-data-dir=/home/coder/.code/data --extensions-dir=/home/coder/.code/extensions --disable-telemetry "$CODER_AUTH_FLAG"
