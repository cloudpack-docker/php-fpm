FROM cloudpack/centos

RUN yum -y update
RUN yum -y install php-fpm php-pecl-memcache
RUN yum -y clean all

RUN sed -ri 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm\/php-fpm.sock/g' /etc/php-fpm.d/www.conf

VOLUME /var/run/php-fpm

CMD /usr/sbin/php-fpm --nodaemonize
