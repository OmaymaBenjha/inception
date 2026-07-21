FROM debian:bookworm

# Install PHP and the PHP-MySQL extension (so it can talk to MariaDB)
RUN apt-get update && \
    apt-get install -y wget php php-fpm php-mysql && \
    rm -rf /var/lib/apt/lists/*

# Create the folders for PHP-FPM
RUN mkdir -p /run/php /var/www/html

# Download the single Adminer PHP file and rename it to adminer.php
RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/adminer.php

# Tell PHP-FPM to listen on Port 9000 (instead of a socket) so Nginx can talk to it
RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

# Start PHP-FPM in the foreground
CMD ["/usr/sbin/php-fpm8.2", "-F"]