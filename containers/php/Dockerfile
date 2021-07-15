FROM php:7.4-fpm

RUN apt-get update

RUN apt-get install -y \
	g++ \
	nano \
	msmtp \
	libicu-dev \
	libxml2-dev \
	libxslt1-dev \
	zlib1g-dev \
	libmcrypt-dev \
	libwebp-dev \
	libxpm-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
	libfreetype6-dev \
	git \
	curl \
	pkg-config \
	patch

RUN docker-php-ext-configure \
	gd --with-freetype --with-jpeg

RUN docker-php-ext-install -j$(nproc) \ 
	intl \
	soap \
	xsl \
	zip \
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

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
RUN apt-get autoremove -y && apt-get clean all

COPY etc/php.ini /usr/local/etc/php/
