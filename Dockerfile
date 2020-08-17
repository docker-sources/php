FROM php:7.4-alpine

MAINTAINER Fabio J L Ferreira <fabiojaniolima@gmail.com>

# Instala e configura componentes essenciais
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    apk add --no-cache tzdata; \
    cp /usr/share/zoneinfo/Brazil/East /etc/localtime; \
    echo "America/Sao_Paulo" > /etc/timezone

# Extensões do PHP
RUN apk add --no-cache \
        libzip-dev \
        freetype-dev \
        icu-dev \
        postgresql-dev \
        libxml2-dev; \
    \
    docker-php-ext-configure gd --with-freetype; \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql; \
    docker-php-ext-configure pdo_pgsql; \
    \
    docker-php-ext-install -j$(nproc) \
        zip \
        gd \
        exif \
        intl \
        mysqli \
        pdo_mysql \
        pgsql \
        pdo_pgsql \
        sockets \
        soap \
        opcache; \
    \
    # Remove dependências de compilação e limpa o cache de pacotes
    rm -rf /var/cache/apk/*

# arquivos de configuração do Apache e PHP
COPY config/php.ini /usr/local/etc/php

WORKDIR /app

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/app"]
