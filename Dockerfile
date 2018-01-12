FROM ubuntu:16.04

MAINTAINER  Suilong Liang <suilong.liang@worktogether.io>

#RUN sed 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' -i /etc/apt/sources.list && \
#    sed 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' -i /etc/apt/sources.list && \
Run apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:nginx/stable && \
    add-apt-repository -y ppa:nginx/stable && \
    # sed 's/ppa.launchpad.net/launchpad.proxy.ustclug.org/g' -i `grep ppa.launchpad.net -rl /etc/apt/sources.list.d/` && \
    apt-get -y update && \
    apt-get -y install nginx-full supervisor php7.0-fpm php7.0-cli php7.0-curl php7.0-gd php7.0-intl \ 
    php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-simplexml php7.0-soap php7.0-xsl php7.0-zip && \
    apt-get clean 
ADD supervisor/*.conf /etc/supervisor/conf.d/
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
VOLUME ["/var/www/html"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["start"]
