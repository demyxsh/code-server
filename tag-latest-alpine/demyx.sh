#!/bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Symlink docker credentials to root user if ~/.docker exists
if [[ -d /home/demyx/.docker ]]; then
    sudo ln -sf /home/demyx/.docker /root/.docker
fi

code-server /home/demyx --user-data-dir=/home/demyx/.code/data --extensions-dir=/home/demyx/.code/extensions --disable-telemetry
