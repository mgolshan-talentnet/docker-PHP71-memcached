FROM php:7.1

RUN apt-get update \
  && apt-get install -y \
    memcached \
    php-memcached \
    php-curl
