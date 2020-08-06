FROM php:7.4-alpine

MAINTAINER Fabio J L Ferreira <fabiojaniolima@gmail.com>

# Instala e configura componentes essenciais
RUN apk update --no-cache && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    apk add tzdata; \
    cp /usr/share/zoneinfo/Brazil/East /etc/localtime; \
    echo "America/Sao_Paulo" > /etc/timezone

# Instala extensões adicionais do PHP
# Extensão "DG" => http://php.net/manual/pt_BR/book.image.php
RUN apk add libpng-dev && \
    docker-php-ext-configure gd && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    docker-php-ext-install -j${NPROC} gd; \
    \
    # Instala a extensão PHP "exif" => http://php.net/manual/pt_BR/intro.exif.php
    docker-php-ext-configure exif && docker-php-ext-install exif; \
    \
    # Extensão PHP para Internacionalização => http://php.net/manual/pt_BR/book.intl.php
    apk add icu-dev && \
    docker-php-ext-configure intl && docker-php-ext-install intl; \
    \
    # Instala as extensões PHP "mysqli pdo_mysql pgsql pdo_pgsql"
    apk add postgresql-dev && \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install mysqli pdo_mysql pgsql pdo_pgsql; \
    \
    # Implementa uma interface de baixo nível para funções de comunicação sockets
    docker-php-ext-configure sockets && docker-php-ext-install sockets; \
    \
    # Instala a extensão soap
    apk add libxml2-dev && \
    docker-php-ext-configure soap && docker-php-ext-install soap; \
    \
    # Instala a extensão para cache de bytecode OPcache
    docker-php-ext-configure opcache && docker-php-ext-install opcache

# Limpa repositório local
RUN apk del libpng-dev icu-dev postgresql-dev libxml2-dev; \
    rm -rf /var/cache/apk/*

# arquivos de configuração do Apache e PHP
COPY config/php.ini /usr/local/etc/php

WORKDIR /app

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/app"]
