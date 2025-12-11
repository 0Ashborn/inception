#!/bin/bash
set -euo pipefail

# Wait for MariaDB using provided env vars
echo "[wordpress] waiting for mariadb..."
until mariadb -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" -e "SELECT 1;" &>/dev/null; do
    sleep 2
done
echo "[wordpress] mariadb reachable"

# If wp core not present, use wp-cli to download/install at container runtime
if [ ! -f wp-settings.php ]; then
    echo "[wordpress] downloading WordPress core..."
    wp core download --allow-root
fi

if [ ! -f wp-config.php ]; then
    echo "[wordpress] creating wp-config.php..."
    wp config create \
        --allow-root \
        --dbname="${DB_NAME}" \
        --dbuser="${DB_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="${DB_HOST}"
fi

if ! wp core is-installed --allow-root; then
    echo "[wordpress] installing WordPress..."
    wp core install \
        --allow-root \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --admin_email="${WP_ADMIN_EMAIL}"
fi

# ensure permissions
chown -R www-data:www-data /var/www/wordpress

# Start php-fpm in foreground (no infinite loops)
echo "[wordpress] starting php-fpm..."

mkdir -p /run/php
chown www-data:www-data /run/php

exec php-fpm7.4 -F
