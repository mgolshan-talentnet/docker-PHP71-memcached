FROM circleci/php:7.2-fpm-node-browsers

RUN php -m
RUN which php
RUN sudo apt-get update
RUN sudo apt install memcached
#RUN sudo service php7.1-fpm restart
RUN php -m && pwd

RUN cd ~/ \
  && git clone --depth 1 https://github.com/php-memcached-dev/php-memcached.git \
  && cd php-memcached \
  && phpize ./configure make \
  && pwd

RUN ls -l /usr/local/etc/php/conf.d
RUN echo "----------------------------------------------"

#RUN sudo mv modules/ /usr/local/memcached/
RUN echo 'extension=/home/circleci/php-memcached/memcached.so' | \
sudo tee /usr/local/etc/php/conf.d/memcached.ini
#RUN echo 'extension=~/php-memcached/memcached.so' | \
#sudo tee /usr/local/bin/php/fpm/conf.d/memcached.ini

RUN ls -l /usr/local/bin/php

#RUN sudo service php7.1-fpm restart

RUN php -m
