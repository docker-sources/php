FROM php:8.4-cli-alpine3.22

LABEL com.fabiojanio.docker.authors.name="Fábio Jânio Lima Ferreira"
LABEL com.fabiojanio.docker.authors.email="contato@fabiojanio.com"

##----------------------------------##
## Instalações e configurações base ##
##----------------------------------##

RUN set -eux; \
    ln -s /var/www/html /app && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    apk add --no-cache --virtual .fetch-deps tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    apk del --no-network .fetch-deps

##------------------##
## Extensões do PHP ##
##------------------##

# Xdebug
RUN apk add --no-cache --virtual .fetch-deps \
        autoconf \
        automake \
        build-base \
        libtool \
        linux-headers && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    apk del --no-network .fetch-deps

# Extensões principais e suas dependências
RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        freetype-dev \
        postgresql-dev && \
    docker-php-ext-configure gd --with-freetype && \
    docker-php-ext-configure pdo_pgsql --with-pdo-pgsql && \
    docker-php-ext-install -j$(nproc) \
        gd \
        intl \
        bcmath \
        pdo_mysql \
        pdo_pgsql && \
    runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" && \
    apk add --no-cache $runDeps && \
    apk del --no-network .build-deps

##-------------------------##
## Configurações do PHP     ##
##-------------------------##

COPY ./config/php.ini /usr/local/etc/php/

# Configuração do Xdebug
RUN { \
        echo "xdebug.mode=develop,coverage,debug"; \
        echo "xdebug.start_with_request=yes"; \
        echo "xdebug.client_host=host.docker.internal"; \
        echo "xdebug.client_port=9003"; \
        echo "xdebug.idekey=DOCKER"; \
        echo "xdebug.log=/dev/stdout"; \
        echo "xdebug.log_level=0"; \
    } >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

WORKDIR /app

EXPOSE 80

CMD ["php", "-S", "0.0.0.0:80", "-t", "/app"]
