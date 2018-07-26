FROM jguyomard/laravel-php:7.2

LABEL maintainer="Mars Hsu marshsu@gmail.com"

RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
  docker-php-ext-configure exif && \
  docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  docker-php-ext-install exif && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

WORKDIR /var/www/default
