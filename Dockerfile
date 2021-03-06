FROM php:7.2

RUN apt-get update && apt-get install -y \
        git \
        unzip \
        wget \
   --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN pecl install xdebug-2.6.0 \
  && docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | php \
  && mv ./composer.phar /usr/local/bin/composer

COPY ./docker/php/php.ini /usr/local/etc/php/php.ini
COPY . /code

WORKDIR /code

RUN composer install --no-interaction

CMD php /code/src/main.php --data=/data
