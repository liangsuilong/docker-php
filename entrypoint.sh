#!/bin/bash

if [[ $1 == 'start' ]]; then
        
        # Change listen address from UNIX socket to TCP port
	sed "s/\/run\/php\/php${PHP_MAJOR}-fpm.sock/0.0.0.0:9000/g" -i /etc/php/${PHP_MAJOR}/fpm/pool.d/www.conf

        # Change PHP code to www-data
	chown -R www-data:www-data /var/www/html/
        
        # Enable xdebug 
	cat <<-EOF > /etc/php/${PHP_MAJOR}/mods-available/xdebug.ini
	zend_extension=xdebug.so
	xdebug.remote_host=dockerhost
	xdebug.remote_connect_back=0
	xdebug.remote_port=9009
	xdebug.idekey=${PHP_XDEBUG_IDEKEY}
	xdebug.remote_autostart=1
	xdebug.remote_enable=1
	xdebug.cli_color=0
	xdebug.profiler_enable=0
	xdebug.profiler_output_dir="~/xdebug/phpstorm/tmp/profiling"
	xdebug.remote_handler=dbgp
	xdebug.remote_mode=req
	xdebug.var_display_max_children=-1
	xdebug.var_display_max_data=-1
	xdebug.var_display_max_depth=-1
	EOF


        # Run php-fpm in nondaemonize mode
        /usr/sbin/php-fpm${PHP_MAJOR} -F -c /etc/php/${PHP_MAJOR}/fpm/php.ini -y /etc/php/${PHP_MAJOR}/fpm/php-fpm.conf 

elif [[ -z $1 ]]; then
	entrypoint.sh start
fi
