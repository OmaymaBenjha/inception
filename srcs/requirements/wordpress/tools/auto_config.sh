#!/bin/bash
set -e
if [ ! -f /var/www/html/wp-load.php ]; then
    wp core download --allow-root
fi

if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create --allow-root \
        --dbname="$SQL_DB" \
        --dbuser="$SQL_USR" \
        --dbpass="$SQL_PWD" \
        --dbhost="mariadb:3306"
fi

if ! wp core is-installed --allow-root; then
    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USR" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL"
fi

if ! wp user get "$WP_USR" --allow-root &>/dev/null; then
    wp user create --allow-root \
        $WP_USR $WP_EMAIL \
        --user_pass=$WP_PWD \
        --role=author
fi

if ! wp config get WP_REDIS_HOST --allow-root &>/dev/null; then
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE_KEY_SALT "$DOMAIN_NAME" --allow-root
    wp config set WP_CACHE true --raw --allow-root
    wp config set WP_REDIS_PASSWORD "$REDIS_PWD" --allow-root
    
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
fi

exec /usr/sbin/php-fpm8.2 -F