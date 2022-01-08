FROM php:8.1-apache-buster

LABEL maintainer="nimdasx@gmail.com"
LABEL description="php8.1 phalcon5"

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
    gnupg \
    gnupg2 \
    gnupg1 \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql gd \
    && rm -rf /var/lib/apt/lists/*

#psr (phalcon butuh ini)
WORKDIR /usr/local/src
RUN git clone --depth=1 https://github.com/jbboehr/php-psr.git
WORKDIR /usr/local/src/php-psr
RUN phpize \
    && ./configure \
    && make \
    && make test \
    && make install
#RUN echo extension=psr.so | tee -a /usr/local/etc/php/conf.d/psr.ini
WORKDIR /
RUN rm -rf /usr/local/src/php-psr
RUN docker-php-ext-enable psr

#phalcon
WORKDIR /usr/local/src
RUN git clone "git://github.com/phalcon/cphalcon.git"
WORKDIR /usr/local/src/cphalcon
RUN git checkout 5.0.x
WORKDIR /usr/local/src/cphalcon/build
RUN ./install
WORKDIR /
RUN rm -rf /usr/local/src/cphalcon
RUN docker-php-ext-enable phalcon

#sqlsrv
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y \
    msodbcsql17 \
    mssql-tools \
    unixodbc-dev \
    libgssapi-krb5-2 \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv \
    && sed -i 's/TLSv1.2/TLSv1.0/g' /etc/ssl/openssl.cnf