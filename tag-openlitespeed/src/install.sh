#!/bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Define variables
WORDPRESS_DB_NAME="${WORDPRESS_DB_NAME:-}"
WORDPRESS_DB_USER="${WORDPRESS_DB_USER:-}"
WORDPRESS_DB_PASSWORD="${WORDPRESS_DB_PASSWORD:-}"
WORDPRESS_DB_HOST="${WORDPRESS_DB_HOST:-}"

if [[ ! -d "$OPENLITESPEED_ROOT"/wp-admin ]]; then
    echo "WordPress is missing, installing now."
    cp -r "$OPENLITESPEED_CONFIG"/wordpress/* "$OPENLITESPEED_ROOT"

    if [[ "$WORDPRESS_DB_NAME" && "$WORDPRESS_DB_USER" && "$WORDPRESS_DB_PASSWORD" && "$WORDPRESS_DB_HOST" ]]; then
        mv "$OPENLITESPEED_ROOT"/wp-config-sample.php "$OPENLITESPEED_ROOT"/wp-config.php
        sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" "$OPENLITESPEED_ROOT"/wp-config.php
        sed -i "s/username_here/$WORDPRESS_DB_USER/g" "$OPENLITESPEED_ROOT"/wp-config.php
        sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" "$OPENLITESPEED_ROOT"/wp-config.php
        sed -i "s/localhost/$WORDPRESS_DB_HOST/g" "$OPENLITESPEED_ROOT"/wp-config.php 
        
        wp core install \
            --url="${WORDPRESS_DOMAIN:-}" \
            --title="${WORDPRESS_DOMAIN:-}" \
            --admin_user="${WORDPRESS_ADMIN_USER:-}" \
            --admin_password="${WORDPRESS_ADMIN_PASSWORD:-}" \
            --admin_email="${WORDPRESS_ADMIN_EMAIL:-}" \
            --skip-email
        wp rewrite structure '/%category%/%postname%/'
        wp config shuffle-salts
        
        sed -i "s/\$table_prefix = 'wp_';/\$table_prefix = 'wp_';\n\n\/\/ If we're behind a proxy server and using HTTPS, we need to alert Wordpress of that fact\n\/\/ see also http:\/\/codex.wordpress.org\/Administration_Over_SSL#Using_a_Reverse_Proxy\nif (isset($\_SERVER['HTTP_X_FORWARDED_PROTO']) \&\& $\_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {\n\t$\_SERVER['HTTPS'] = 'on';\n}\n/g" "$OPENLITESPEED_ROOT"/wp-config.php
    else
        echo "One or more environment variables are missing! Exiting ... "
        exit 1
    fi
fi
