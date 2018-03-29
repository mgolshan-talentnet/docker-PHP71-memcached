FROM circleci/php:7.2-fpm-node-browsers

RUN php -m
RUN which php
RUN sudo apt-get update
RUN sudo apt install memcached
RUN sudo apt-get install php5-memcached
#RUN sudo service php7.1-fpm restart
RUN php -m && pwd
#RUN yum install zlib-devel

