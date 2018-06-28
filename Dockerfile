FROM php:7.1-fpm
MAINTAINER mgolshan <mgolshan@talentnet.com>
# Extended from neolao <contact@neolao.com>

RUN apt-get update

# Install opcache
RUN docker-php-ext-install opcache

# Install APCu
RUN pecl install apcu
RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini

# Install bcmath
RUN docker-php-ext-install bcmath

# Install bz2
RUN apt-get install -y libbz2-dev
RUN docker-php-ext-install bz2

# Install calendar
RUN docker-php-ext-install calendar

# Install dba
RUN docker-php-ext-install dba

# Install GD
#RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Install mbstring
RUN docker-php-ext-install mbstring

# Install mcrypt
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install mcrypt

# Install PDO
# RUN apt-get install -y freetds-dev php5-sybase
# RUN docker-php-ext-install pdo 
RUN docker-php-ext-install pdo_mysql
# RUN docker-php-ext-install pdo_oci
# RUN docker-php-ext-install pdo_odbc
RUN apt-get install -y libpq-dev
RUN docker-php-ext-install pdo_pgsql
# RUN apt-get install -y libsqlite3-dev
# RUN docker-php-ext-install pdo_sqlite

# Install phpredis 2.2.7
RUN apt-get install -y unzip
WORKDIR /root
COPY phpredis-2.2.7.zip phpredis-2.2.7.zip
RUN unzip phpredis-2.2.7.zip
WORKDIR phpredis-2.2.7
RUN phpize && ./configure && make && make install
#RUN cp /root/phpredis-2.2.7/modules/redis.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012/
RUN echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# Install XSL
RUN apt-get install -y libxslt-dev
RUN docker-php-ext-install xsl

# Install ZipLib
RUN apt-get install -y libzip-dev

# Install xmlrpc
RUN docker-php-ext-install xmlrpc

# Install memcached
COPY memcached-2.2.0.zip memcached-2.2.0.zip
RUN apt-get install -y memcached libmemcached-dev zlib1g-dev libncurses5-dev
RUN mkdir /usr/src/php && mkdir /usr/src/php/ext && mkdir /usr/src/php/ext/memcached-2.2.0
RUN unzip memcached-2.2.0.zip -d /usr/src/php/ext/memcached-2.2.0 && rm memcached-2.2.0.zip
RUN docker-php-ext-install memcached-2.2.0

# Install MongoDB library
RUN pecl install mongodb
RUN echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini

# Install Zip library
RUN pecl install zip
RUN echo "extension=zip.so" > /usr/local/etc/php/conf.d/zip.ini

# install yaml
RUN echo Y | apt-get install libyaml-dev
RUN echo autdetect | pecl install yaml
RUN echo "extension=yaml.so" > /usr/local/etc/php/conf.d/yaml.ini

# Install mongo
#RUN pecl install mongodb-beta
#RUN echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini

# Install ftp
#RUN docker-php-ext-install ftp

# Install intl
#RUN apt-get install -y libicu-dev
#RUN pecl install intl
#RUN docker-php-ext-install intl

# Install Vim
RUN apt -y install vim

# Install Net Tools
#RUN apt -y install net-tools

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Install Git
RUN echo Y | apt-get install git-core

# Include the start script
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

CMD ["start.sh"]
