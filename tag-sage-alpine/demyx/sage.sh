#!/bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

while :; do
    case "${1:-}" in
        init)
            SAGE_COMMAND="$1"
            ;;
        help)
            SAGE_COMMAND="$1"
            ;;
        new)
            SAGE_COMMAND="$1"
            ;;
        -t)
            SAGE_THEME="${2}"
            shift
            ;;
        --)
            shift
            break
            ;;
        -?*)
            printf '\e[31m[CRITICAL]\e[39m Unknown option: %s\n' "$1" >&2
            exit 1
            ;;
        *)
            break
    esac
    shift
done

SAGE_THEME="${SAGE_THEME:-sage}"
[[ -z "${SAGE_COMMAND:-}" ]] && SAGE_COMMAND="$@"
SAGE_WEBPACK_CONFIG="$CODE_SERVER_ROOT"/web/app/themes/"$SAGE_THEME"/resources/assets/build/webpack.config.watch.js

if [[ "$SAGE_COMMAND" = init ]]; then
    WP_HOME="$(grep WP_HOME= "$CODE_SERVER_ROOT"/.env | awk -F '[=]' '{print $2}')"
    WP_DOMAIN="$(echo $WP_HOME | awk -F/ '{print $3}')"
    [[ ! -d "$CODE_SERVER_ROOT"/web/app/themes/"$SAGE_THEME" ]] && echo -e "\n\e[31m$SAGE_THEME doesn't exist\e[39m\n" && sage help && exit 1
    echo -e "$(cat "$CODE_SERVER_CONFIG"/bs.js)\n$(cat "$SAGE_WEBPACK_CONFIG")" > "$SAGE_WEBPACK_CONFIG"
    sed -i "s|delay: 500|delay: 500, advanced: demyxBS|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|config.proxyUrl +|'$WP_HOME' +|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|domain.tld|$WP_DOMAIN|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|example.test|${BROWSERSYNC_PROXY:-}|g" "$CODE_SERVER_ROOT"/web/app/themes/"$SAGE_THEME"/resources/assets/config.json
    echo -e "\nmodule.hot.accept();" >> "$CODE_SERVER_ROOT"/web/app/themes/"$SAGE_THEME"/resources/assets/scripts/main.js
elif [[ "$SAGE_COMMAND" = help ]]; then
    echo "sage <arg>        Sage helper script"
    echo
    echo "     init         Initializes fixes for webpack"
    echo "                  Ex: sage -t <theme> init"
    echo
    echo "     help         Help menu for sage helper script"
    echo "                  Ex: sage help"
    echo
    echo "     new          Executes composer create-project, yarn, and sage -t <theme> init"
    echo "                  Ex: sage -t <theme> new"
    echo
    echo "     -t           Set the theme"
    echo "                  Ex: sage -t <theme> add <package>"
elif [[ "$SAGE_COMMAND" = new ]]; then
    [[ -d "$CODE_SERVER_ROOT"/web/app/themes/"$SAGE_THEME" ]] && echo -e "\n\e[31m$SAGE_THEME already exists\e[39m\n" && sage help && exit 1
    composer create-project roots/sage "$CODE_SERVER_ROOT"/web/app/themes/"$SAGE_THEME"
    yarn --cwd="$CODE_SERVER_ROOT"/web/app/themes/"$SAGE_THEME"
    wp theme activate $SAGE_THEME/resources
    sage -t "$SAGE_THEME" init
else
    [[ -z "$SAGE_COMMAND" ]] && echo -e "\n\e[31mMissing command for yarn\e[39m\n" && sage help && exit 1
    echo -e "[\e[34m${SAGE_THEME}\e[39m] yarn $SAGE_COMMAND"
    yarn --cwd="$CODE_SERVER_ROOT"/web/app/themes/"$SAGE_THEME" $SAGE_COMMAND
fi
