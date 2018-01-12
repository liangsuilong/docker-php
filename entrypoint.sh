#!/bin/bash

PHP_VERSION=7.0

if [[ $1 == 'start' ]]; then
	sed "s/www-data/root/g" -i /etc/nginx/nginx.conf
	sed "s/\/run\/php\/php${PHP_VERSION}-fpm.pid/\/run\/php${PHP_VERSION}-fpm.pid/g" -i /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
	sed "s/www-data/root/g" -i /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
	sed "s/\/run\/php\/php${PHP_VERSION}-fpm.sock/0.0.0.0:9000/g" -i /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
	if [[ -e /var/www/html/nginx.conf ]]; then
		rm -f /etc/nginx/sites-enabled/default
		ln -s /var/www/html/nginx.conf /etc/nginx/sites-enabled/site.conf
	fi
        /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
elif [[ -z $1 ]]; then
	entrypoint.sh start
fi
