FROM php:8.3-apache-bookworm

LABEL maintainer="nimdasx@gmail.com" \
    description="apache php-8.3 phalcon-5.8"

#config php
COPY php-nimdasx.ini /usr/local/etc/php/conf.d/php-nimdasx.ini

#config apache
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

#timezone dan apache
RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
    && a2enmod rewrite remoteip headers \
    && sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/-Indexes/+Indexes/' /etc/apache2/conf-enabled/docker-php.conf

#dependensi
RUN apt-get -y update \
    && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libpq-dev \
    && echo "configure dan install" \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql pdo_pgsql gd zip mysqli \
    && echo "hapus" \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/pear

#redis dan phalcon
RUN pecl install redis phalcon-5.8.0 \
    && docker-php-ext-enable redis phalcon \
    && echo "hapus" \
    && rm -rf /tmp/pear

#sqlsrv
# RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
#     && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
#     && apt-get update \
#     && ACCEPT_EULA=Y apt-get install -y \
#     msodbcsql17 \
#     mssql-tools \
#     unixodbc-dev \
#      libgssapi-krb5-2 \
#     && rm -rf /var/lib/apt/lists/* \
#     && pecl install sqlsrv pdo_sqlsrv \
#     && docker-php-ext-enable sqlsrv pdo_sqlsrv \
#     && sed -i 's/TLSv1.2/TLSv1.0/g' /etc/ssl/openssl.cnf