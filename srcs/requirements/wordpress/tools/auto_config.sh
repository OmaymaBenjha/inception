#!/bin/bash

sleep 10

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
    
    wp config create --allow-root \
        --dbname=$SQL_DB \
        --dbuser=$SQL_USR \
        --dbpass=$SQL_PWD \
        --dbhost=mariadb:3306

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USR \
        --admin_password=$WP_ADMIN_PWD \
        --admin_email=$WP_ADMIN_EMAIL

    wp user create --allow-root \
        $WP_USR $WP_EMAIL \
        --user_pass=$WP_PWD \
        --role=author
fi

exec /usr/sbin/php-fpm8.2 -F