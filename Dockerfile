FROM cloudpack/centos

RUN yum -y update
RUN yum -y install php-fpm php-mbstring php-mysql php-pecl-memcache
RUN yum -y clean all

RUN sed -ri 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm\/php-fpm.sock/g' /etc/php-fpm.d/www.conf

RUN cp -rfp /etc/php-fpm.d /etc/php-fpm.d-org
RUN cp -rfp /etc/php.d /etc/php.d-org

CMD test -z "$(ls -A /etc/php-fpm.d)" && cp -rfp /etc/php-fpm.d-org/* /etc/php-fpm.d ;\
    test -z "$(ls -A /etc/php.d)" && cp -rfp /etc/php.d-org/* /etc/php.d ;\
    /usr/sbin/php-fpm --nodaemonize

VOLUME /var/run/php-fpm
VOLUME /var/log/php-fpm
VOLUME /etc/php.d 
VOLUME /etc/php-fpm.d
