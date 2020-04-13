#!/bin/bash
# Demyx
# https://demyx.sh
set -euo pipefail

# Define variables
WORDPRESS_DOMAIN="${OPENLITESPEED_DOMAIN:-domain.tld}"
WORDPRESS_SSL="${WORDPRESS_SSL:-false}"
WORDPRESS_PROTO="$WORDPRESS_DOMAIN"
WORDPRESS_DB_NAME="${WORDPRESS_DB_NAME:-}"
WORDPRESS_DB_USER="${WORDPRESS_DB_USER:-}"
WORDPRESS_DB_PASSWORD="${WORDPRESS_DB_PASSWORD:-}"
WORDPRESS_DB_HOST="${WORDPRESS_DB_HOST:-}"

if [[ ! -f "$OPENLITESPEED_ROOT"/.env ]]; then
    echo "[demyx] Installing Bedrock..."
    tar -xzf "$OPENLITESPEED_CONFIG"/bedrock.tgz -C "$OPENLITESPEED_CONFIG"
    cp -r "$OPENLITESPEED_CONFIG"/bedrock/. "$OPENLITESPEED_ROOT"
    rm -rf "$OPENLITESPEED_CONFIG"/bedrock

    if [[ "$WORDPRESS_DB_NAME" && "$WORDPRESS_DB_USER" && "$WORDPRESS_DB_PASSWORD" && "$WORDPRESS_DB_HOST" && -n "$WORDPRESS_DOMAIN" ]]; then
        [[ "$WORDPRESS_SSL" = true ]] && WORDPRESS_PROTO="https://$WORDPRESS_DOMAIN"
        sed -i "s|WP_HOME=.*|WP_HOME=$WORDPRESS_PROTO|g" "$OPENLITESPEED_ROOT"/.env
        sed -i "s|database_name|$WORDPRESS_DB_NAME|g" "$OPENLITESPEED_ROOT"/.env
        sed -i "s|database_user|$WORDPRESS_DB_USER|g" "$OPENLITESPEED_ROOT"/.env
        sed -i "s|database_password|$WORDPRESS_DB_PASSWORD|g" "$OPENLITESPEED_ROOT"/.env
        sed -i "s|# DB_HOST=localhost|DB_HOST=$WORDPRESS_DB_HOST|g" "$OPENLITESPEED_ROOT"/.env
        sed -i "s|WP_ENV=.*|WP_ENV=development|g" "$OPENLITESPEED_ROOT"/.env
        
        wp core install \
            --url="${WORDPRESS_PROTO:-}" \
            --title="${WORDPRESS_DOMAIN:-}" \
            --admin_user="${WORDPRESS_ADMIN_USER:-}" \
            --admin_password="${WORDPRESS_ADMIN_PASSWORD:-}" \
            --admin_email="${WORDPRESS_ADMIN_EMAIL:-}" \
            --skip-email
        
        wp rewrite structure '/%category%/%postname%/'

        echo \"[demyx] Installing Sage...\"
        tar -xzf "$OPENLITESPEED_CONFIG"/sage.tgz -C "$OPENLITESPEED_ROOT"/web/app/themes
        rm -rf "$OPENLITESPEED_ROOT"/web/wp/wp-content/themes/twenty*
        rm -rf "$OPENLITESPEED_ROOT"/web/wp/wp-content/plugins/hello.php
        wp theme activate sage/resources
        sage init
    else
        echo "One or more environment variables are missing! Exiting ... "
        exit 1
    fi
fi
