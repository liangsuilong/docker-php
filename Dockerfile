FROM ubuntu:16.04

MAINTAINER  Suilong Liang <suilong.liang@worktogether.io>

ENV PHP_VERSION 7.0
ENV LC_ALL C.UTF-8

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r www-data && useradd -r -g www-data www-data

# Manually Add Ondrej PHP PPA https://launchpad.net/~ondrej/+archive/ubuntu/php
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C && \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y install php${PHP_VERSION}-fpm php${PHP_VERSION}-cli php${PHP_VERSION}-curl php${PHP_VERSION}-gd php${PHP_VERSION}-intl php-xdebug \ 
    php${PHP_VERSION}-mbstring php${PHP_VERSION}-mcrypt php${PHP_VERSION}-mysql php${PHP_VERSION}-simplexml php${PHP_VERSION}-soap php${PHP_VERSION}-xsl php${PHP_VERSION}-zip && \
    apt-get clean 

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

RUN mkdir -p /run/php/

VOLUME /var/www/html/ /etc/php/${PHP_VERSION}/fpm/

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["start"]
