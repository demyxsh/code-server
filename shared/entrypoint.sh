#!/usr/bin/dumb-init /bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Symlink docker credentials to root user if ~/.docker exists
if [[ -d /home/demyx/.docker ]]; then
    sudo ln -sf /home/demyx/.docker /root/.docker
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- code-server "$@"
fi

exec "$@"
