#!/bin/bash
# Demyx
# https://demyx.sh

SAGE_COMMAND="$1"
SAGE_THEME="$2"
SAGE_WEBPACK_CONFIG=/var/www/html/web/app/themes/"$SAGE_THEME"/resources/assets/build/webpack.config.watch.js

if [[ "$SAGE_COMMAND" = init ]]; then
    echo -e "$(cat /usr/src/bs.js)\n$(cat /var/www/html/web/app/themes/$SAGE_THEME/resources/assets/build/webpack.config.watch.js)" > "$SAGE_WEBPACK_CONFIG"
    sed -i "s|delay: 500|delay: 500, advanced: demyxBS|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|config.proxyUrl +|'$WORDPRESS_PROTO' +|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|domain.tld|$WORDPRESS_DOMAIN|g" "$SAGE_WEBPACK_CONFIG"
    sed -i "s|example.test|$(hostname)|g" /var/www/html/web/app/themes/"$SAGE_THEME"/resources/assets/config.json
    echo -e "\nmodule.hot.accept();" >> /var/www/html/web/app/themes/"$SAGE_THEME"/resources/assets/scripts/main.js
elif [[ "$SAGE_COMMAND" = new ]]; then
    composer create-project roots/sage /var/www/html/web/app/themes/"$SAGE_THEME"
    yarn --cwd=/var/www/html/web/app/themes/"$SAGE_THEME"
    wp theme activate $SAGE_THEME/resources
    sage init "$SAGE_THEME"
else
    SAGE_THEME="$1"
    SAGE_COMMAND="$2"

    [[ -z "$SAGE_THEME" ]] && SAGE_THEME=sage
    [[ -z "$SAGE_COMMAND" ]] && SAGE_COMMAND=start

    echo -e "[\e[34m${SAGE_THEME}\e[39m] yarn $SAGE_COMMAND"
    yarn --cwd=/var/www/html/web/app/themes/"$SAGE_THEME" "$SAGE_COMMAND"
fi
