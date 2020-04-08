FROM php:7.3-apache
RUN apt-get update \
    && apt-get install --no-install-recommends -y locales gettext zip libfreetype6-dev libjpeg62-turbo-dev libgd-dev libpng-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-install mysqli gd sockets bcmath gettext \
    && printf '[PHP]\ndate.timezone = "Europe/Rome"\n' > /usr/local/etc/php/conf.d/tzone.ini \
    && a2enmod rewrite \
    && sed -i 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen it_IT.UTF-8

ENV LANG it_IT.UTF-8
ENV LANGUAGE it_IT:it
ENV LC_ALL it_IT.UTF-8
# Zabbix
COPY ./data /var/www/html
RUN /var/www/html/zabbix/locale/make_mo.sh \
    && chown -R www-data:www-data /var/www/html