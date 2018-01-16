#!/bin/bash

PHP_VERSION=7.1

if [[ $1 == 'start' ]]; then
	sed "s/\/run\/php\/php${PHP_VERSION}-fpm.pid/\/run\/php${PHP_VERSION}-fpm.pid/g" -i /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
	sed "s/www-data/root/g" -i /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
	sed "s/\/run\/php\/php${PHP_VERSION}-fpm.sock/0.0.0.0:9000/g" -i /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
        /usr/sbin/php-fpm${PHP_VERSION} -F -R -c /etc/php/${PHP_VERSION}/fpm/php.ini -y /etc/php/${PHP_VERSION}/fpm/php-fpm.conf 

elif [[ -z $1 ]]; then
	entrypoint.sh start
fi
