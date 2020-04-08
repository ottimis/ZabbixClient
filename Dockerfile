FROM php:7.3-apache
RUN apt-get update \
    && apt-get install --no-install-recommends -y zip libfreetype6-dev libjpeg62-turbo-dev libgd-dev libpng-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-install mysqli gd sockets bcmath \
    && sed 's/^;date\.timezone[[:space:]]=.*$/date.timezone = "Europe\/Rome"/' /usr/local/etc/php/php.ini-production &&\
    a2enmod rewrite
# Zabbix
COPY ./data /var/www/html