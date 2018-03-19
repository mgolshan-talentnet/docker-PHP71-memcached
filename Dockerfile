FROM php:7.1-apache

RUN apt-get install memcached
RUN apt-get update && apt-get install -y libmemcached11 libmemcachedutil2 build-essential libmemcached-dev libz-dev
RUN pecl install memcached-2.2.0
RUN echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
