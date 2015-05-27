FROM cloudpack/centos

RUN yum -y update
RUN yum -y install php-fpm php-pecl-memcache
RUN yum -y clean all

RUN sed -ri 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm\/php-fpm.sock/g' /etc/php-fpm.d/www.conf

VOLUME /etc/php-fpm.d
RUN cp -rfp /etc/php-fpm.d /etc/php-fpm.d-org
VOLUME /etc/php.d 
RUN cp -rfp /etc/php.d /etc/php.d-org

VOLUME /var/run/php-fpm
CMD test -z "$(ls -A /etc/php-fpm.d)" && cp -rfp /etc/php-fpm.d-org/* /etc/php-fpm.d ;\
    test -z "$(ls -A /etc/php.d)" && cp -rfp /etc/php.d-org/* /etc/php.d ;\
    /usr/sbin/php-fpm --nodaemonize
