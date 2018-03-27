FROM circleci/php:7.2-fpm-node-browsers

RUN php -m

RUN sudo apt-get update -y \
&& apt install memcached \
&& apt install php-memcached \
&& service php7.1-fpm restart

RUN php -m
