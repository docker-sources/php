FROM php:8.0-cli-alpine3.14

LABEL com.fabiojanio.image.authors.name="Fabio J L Ferreira"
LABEL com.fabiojanio.image.authors.email="fabiojaniolima@gmail.com"

##----------------------------------##
## Instalações e configurações base ##
##----------------------------------##

# Instala o composer e pacote para paralelismo
RUN ln -s /var/www/html /app  && \
    \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    \
    # Instala e configura timezone
    apk add --no-cache --virtual .fetch-deps tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    apk del tzdata; \
    apk del --no-network .fetch-deps

##------------------##
## Extensões do PHP ##
##------------------##

# Dependências para compilação das extensões
RUN apk add --no-cache \
        freetype-dev \
        postgresql-dev && \
    \
    docker-php-ext-configure gd --with-freetype && \
    \
    docker-php-ext-install -j$(nproc) \
        gd \
        intl \
        bcmath \
        pdo_mysql \
        pdo_pgsql

COPY config/php.ini /usr/local/etc/php

WORKDIR /app

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/app"]
