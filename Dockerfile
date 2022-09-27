FROM php:8.1-apache-bullseye

LABEL maintainer="nimdasx@gmail.com"
LABEL description="php-8.1 phalcon-5"

#set timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

#config php
COPY php-nimdasx.ini /usr/local/etc/php/conf.d/php-nimdasx.ini

#apache
RUN a2enmod rewrite \
    && sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/-Indexes/+Indexes/' /etc/apache2/conf-enabled/docker-php.conf

#dependensi
RUN apt-get -y update \
    && apt-get install -y \
    unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    gnupg \
    gnupg2 \
    gnupg1 \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql gd zip mysqli \
    && rm -rf /var/lib/apt/lists/*

#phalcon 5 stable
RUN pecl install phalcon-5.0.1 \
    && docker-php-ext-enable phalcon

#sqlsrv
#RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
#    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
#    && apt-get update \
#    && ACCEPT_EULA=Y apt-get install -y \
#    msodbcsql17 \
#    mssql-tools \
#    unixodbc-dev \
#    libgssapi-krb5-2 \
#    && rm -rf /var/lib/apt/lists/* \
#    && pecl install sqlsrv pdo_sqlsrv \
#    && docker-php-ext-enable sqlsrv pdo_sqlsrv \
#    && sed -i 's/TLSv1.2/TLSv1.0/g' /etc/ssl/openssl.cnf
