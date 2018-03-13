circleci/php:7.1-browsers

RUN sudo apt-get update \
  && sudo apt-get install memcached \
    && sudo apt-get install php-memcached \
      && sudo apt-get install php-curl
