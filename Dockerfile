FROM php:8.1-cli-alpine3.16

LABEL com.fabiojanio.image.authors.name="Fabio J L Ferreira"
LABEL com.fabiojanio.image.authors.email="fabiojaniolima@gmail.com"

##----------------------------------##
## Instalações e configurações base ##
##----------------------------------##

# Instala o composer e pacote para paralelismo
RUN set -eux; \
    ln -s /var/www/html /app  && \
    \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    \
    # Instala e configura timezone
    apk add --no-cache --virtual .fetch-deps tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    apk del --no-network .fetch-deps

##------------------##
## Extensões do PHP ##
##------------------##

# Dependências para compilação das extensões
RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
            $PHPIZE_DEPS \
            freetype-dev \
            postgresql-dev && \
        \
        docker-php-ext-configure gd --with-freetype && \
        docker-php-ext-configure pdo_pgsql --with-pdo-pgsql && \
        \
        docker-php-ext-install -j$(nproc) \
            gd \
            intl \
            bcmath \
            pdo_mysql \
            pdo_pgsql && \
        \
        runDeps="$( \
            scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
                | tr ',' '\n' \
                | sort -u \
                | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
        )" && \
        apk add --no-cache $runDeps && \
        \
        apk del --no-network .build-deps

COPY config/php.ini /usr/local/etc/php

WORKDIR /app

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/app"]
