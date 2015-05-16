FROM centos:centos7

RUN yum -y update
RUN yum -y install php-fpm
RUN yum -y clean all

CMD ["/usr/sbin/php-fpm", "--nodaemonize" ]
