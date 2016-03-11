FROM cloudpack/centos:0.0.0

RUN yum -y update
RUN yum -y install php-fpm php-mbstring php-mysql php-pecl-memcache postfix epel-release
RUN yum -y install php-pecl-imagick php-mcrypt
RUN yum -y clean all

RUN mkdir /var/lib/php/session
RUN chown apache:apache /var/lib/php/session

CMD /usr/sbin/postfix start && /usr/sbin/php-fpm --nodaemonize

VOLUME /var/run/php-fpm
VOLUME /var/log/php-fpm
VOLUME /etc/php.d 
VOLUME /etc/php-fpm.d
