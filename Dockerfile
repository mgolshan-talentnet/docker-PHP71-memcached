FROM php:7.1

RUN apt-get update \
  && apt-get install -y \
    memcached \
    "php7.1-memcached" \
    "php7.1-curl"
