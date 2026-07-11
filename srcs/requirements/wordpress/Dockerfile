FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	php-mysql \
	php8.2-fpm \
	mariadb-client \
	wget \
	curl \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's|/listen = /run/php/php8.2-fpm.sock/|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf


WORKDIR /var/www/html

COPY ./tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh


EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

