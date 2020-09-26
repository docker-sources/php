FROM php:7.4-alpine

MAINTAINER Fabio J L Ferreira <fabiojaniolima@gmail.com>

##----------------------------------##
## Instalações e configurações base ##
##----------------------------------##

# Instala o composer e pacote para paralelismo
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    composer global require hirak/prestissimo; \
    \
    # Instala e configura timezone
    apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone


##------------------##
## Extensões do PHP ##
##------------------##

# Dependências para compilação das extensões
RUN apk add --no-cache \
        libzip-dev \
        freetype-dev \
        icu-dev \
        postgresql-dev \
        libxml2-dev && \
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
        opcache

# Limpa o cache do APK, do Composer e remove os pacotes de timezone
RUN rm -rf /var/cache/apk/*; \
    apk del tzdata; \
    composer cc

# arquivos de configuração do Apache e PHP
COPY config/php.ini /usr/local/etc/php

WORKDIR /app

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/app"]
