FROM circleci/php:7.2-fpm-node-browsers

RUN php -m

RUN sudo apt-get update
RUN sudo apt install memcached
RUN sudo apt install php-memcached
RUN sudo service php7.1-fpm restart

RUN php -m
