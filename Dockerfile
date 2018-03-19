FROM circleci/php:7.2-fpm-node-browsers

# ... 

RUN sudo apt-get update && apt-get install -y \
    libmemcached-dev \
    curl

# ... 

# Install Memcached for php 7
RUN sudo curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" \
    && mkdir -p /usr/src/php/ext/memcached \
    && tar -C /usr/src/php/ext/memcached -zxvf /tmp/memcached.tar.gz --strip 1 \
    && docker-php-ext-configure memcached \
    && docker-php-ext-install memcached \
    && rm /tmp/memcached.tar.gz
    
