#!/bin/bash

PHP_MAJOR=7.0

if [[ $1 == 'start' ]]; then
        
        # Change listen address from UNIX socket to TCP port
	sed "s/\/run\/php\/php${PHP_MAJOR}-fpm.sock/0.0.0.0:9000/g" -i /etc/php/${PHP_MAJOR}/fpm/pool.d/www.conf

        # Change PHP code to www-data
	chown -R www-data:www-data /var/www/html/
        
        # Enable xdebug 
        echo "xdebug.remote_enable=on" >> /etc/php/${PHP_MAJOR}/mods-available/xdebug.ini
        echo "xdebug.remote_port=9000" >> /etc/php/${PHP_MAJOR}/mods-available/xdebug.ini
        echo 'xdebug.remote_handler="dbgp"' >> /etc/php/${PHP_MAJOR}/mods-available/xdebug.ini
        echo "xdebug.remote_connect_back=1" >> /etc/php/${PHP_MAJOR}/mods-available/xdebug.ini

        # Run php-fpm in nondaemonize mode
        /usr/sbin/php-fpm${PHP_MAJOR} -F -c /etc/php/${PHP_MAJOR}/fpm/php.ini -y /etc/php/${PHP_MAJOR}/fpm/php-fpm.conf 

elif [[ -z $1 ]]; then
	entrypoint.sh start
fi
