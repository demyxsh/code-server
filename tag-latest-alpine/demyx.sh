#!/bin/bash
# Demyx
# https://demyx.sh

# Execute command before starting up code-server
"$@"

# Symlink docker credentials to root user if ~/.docker exists
if [[ -d /home/demyx/.docker ]]; then
    sudo ln -s /home/demyx/.docker /root/.docker
fi

# Set default workdir
if [[ -z "$CODER_WORKDIR" ]]; then
    CODER_WORKDIR=/home/demyx
fi

code-server $(echo "$CODER_WORKDIR") --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry
