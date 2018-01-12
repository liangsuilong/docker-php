FROM ubuntu:16.04

MAINTAINER  Suilong Liang <suilong.liang@worktogether.io>

ENV PHP_VERSION 7.1

#RUN sed 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' -i /etc/apt/sources.list && \
#    sed 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' -i /etc/apt/sources.list && \
Run apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:nginx/stable && \
    add-apt-repository -y ppa:nginx/stable && \
    # sed 's/ppa.launchpad.net/launchpad.proxy.ustclug.org/g' -i `grep ppa.launchpad.net -rl /etc/apt/sources.list.d/` && \
    apt-get -y update && \
    apt-get -y install nginx-full supervisor php${PHP_VERSION}-fpm php${PHP_VERSION}-cli php${PHP_VERSION}-curl php${PHP_VERSION}-gd php${PHP_VERSION}-intl \ 
    php${PHP_VERSION}-mbstring php${PHP_VERSION}-mcrypt php${PHP_VERSION}-mysql php${PHP_VERSION}-simplexml php${PHP_VERSION}-soap php${PHP_VERSION}-xsl php${PHP_VERSION}-zip && \
    apt-get clean 
ADD supervisor/*.conf /etc/supervisor/conf.d/
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
VOLUME ["/var/www/html"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["start"]
