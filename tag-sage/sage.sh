#!/bin/bash

SAGE_THEME="$1"
SAGE_COMMAND="$2"

[[ -z "$SAGE_THEME" ]] && SAGE_THEME=sage
[[ -z "$SAGE_COMMAND" ]] && SAGE_COMMAND=start

echo -e "[\e[34m${SAGE_THEME}\e[39m] yarn $SAGE_COMMAND"
yarn --cwd=/var/www/html/web/app/themes/"$SAGE_THEME" "$SAGE_COMMAND"
