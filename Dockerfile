FROM circleci/php:7.2-fpm-node-browsers

RUN php -m
RUN which php
RUN sudo apt-get update
RUN sudo apt install memcached
RUN sudo service php7.1-fpm restart
RUN php -m

RUN git clone --depth 1 https://github.com/php-memcached-dev/php-memcached.git \
  && cd php-memcached \
  && phpize ./configure make

RUN sudo mv modules/ /usr/local/memcached/
RUN echo 'extension=/usr/local/memcached/memcached.so' | \
sudo tee /usr/local/bin/php/cli/conf.d/memcached.ini
RUN echo 'extension=/usr/local/memcached/memcached.so' | \
sudo tee /usr/local/bin/php/fpm/conf.d/memcached.ini

RUN sudo service php7.1-fpm restart

RUN php -m
