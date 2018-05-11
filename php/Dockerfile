FROM php:7-apache

RUN apt-get update

RUN apt-get install -y \
	g++ \
	nano \
	cron \
	msmtp \
	libicu-dev \
	libxml2-dev \
	libxslt1-dev \
	zlib1g-dev \
	libmcrypt-dev \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng12-dev

RUN docker-php-ext-configure \
	gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install -j$(nproc) \ 
	intl \
	soap \
	xsl \
	zip \
	mcrypt \
	pdo \
	pdo_mysql \
	gd \
	gettext \
	mbstring \
	opcache \
	bcmath

RUN pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable_trigger=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_output_dir=/var/www/html/profile" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN a2enmod rewrite

RUN apt-get autoremove -y && apt-get clean all

COPY etc/php.ini /usr/local/etc/php/
