#!/bin/bash
# Demyx
# https://demyx.sh

while :; do
    case "$1" in
        init)
            SAGE_COMMAND=init
            ;;
        help)
            SAGE_COMMAND=help
            ;;
        new)
            SAGE_COMMAND=new
            ;;
        -t)
            SAGE_THEME=${2}
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

[[ -z "$SAGE_THEME" ]]  && SAGE_THEME=sage
[[ -z "$SAGE_COMMAND" ]] && SAGE_COMMAND="$@"
SAGE_WEBPACK_CONFIG=/var/www/html/web/app/themes/"$SAGE_THEME"/resources/assets/build/webpack.config.watch.js

if [[ "$SAGE_COMMAND" = init ]]; then
    WP_HOME="$(grep WP_HOME= /var/www/html/.env | awk -F '[=]' '{print $2}')"
    [[ ! -d /var/www/html/web/app/themes/"$SAGE_THEME" ]] && echo -e "\n\e[31m$SAGE_THEME doesn't exist\e[39m\n" && sage help && exit 1
    echo -e "$(cat /usr/src/bs.js)\n$(cat $SAGE_WEBPACK_CONFIG)" > "$SAGE_WEBPACK_CONFIG"
    sed -i "s|delay: 500|delay: 500, advanced: demyxBS|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|config.proxyUrl +|'$WP_HOME' +|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|domain.tld|$WORDPRESS_DOMAIN|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|example.test|$(hostname)|g" /var/www/html/web/app/themes/"$SAGE_THEME"/resources/assets/config.json
    echo -e "\nmodule.hot.accept();" >> /var/www/html/web/app/themes/"$SAGE_THEME"/resources/assets/scripts/main.js
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
    [[ -d /var/www/html/web/app/themes/"$SAGE_THEME" ]] && echo -e "\n\e[31m$SAGE_THEME already exists\e[39m\n" && sage help && exit 1
    composer create-project roots/sage /var/www/html/web/app/themes/"$SAGE_THEME"
    yarn --cwd=/var/www/html/web/app/themes/"$SAGE_THEME"
    wp theme activate $SAGE_THEME/resources
    sage -t "$SAGE_THEME" init
else
    [[ -z "$SAGE_COMMAND" ]] && echo -e "\n\e[31mMissing command for yarn\e[39m\n" && sage help && exit 1
    echo -e "[\e[34m${SAGE_THEME}\e[39m] yarn $SAGE_COMMAND"
    yarn --cwd=/var/www/html/web/app/themes/"$SAGE_THEME" $SAGE_COMMAND
fi
