FROM php:7.4-fpm

RUN apt-get update

RUN apt-get update --fix-missing \
    && apt-get install -y \
	g++ nano msmtp libicu-dev libxml2-dev libxslt1-dev zlib1g-dev \
	libmcrypt-dev libwebp-dev libxpm-dev libjpeg62-turbo-dev libpng-dev libfreetype6-dev git \
	curl pkg-config patch webp libssl-dev librdkafka-dev libzookeeper-mt-dev libzip-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get autoremove -y && apt-get clean all

RUN docker-php-ext-configure \
	gd --with-freetype --with-jpeg

RUN docker-php-ext-install -j$(nproc) \ 
	intl soap xsl zip pdo pdo_mysql gd \
	gettext mbstring opcache bcmath

RUN pecl channel-update pecl.php.net
RUN pecl install xdebug-2.9.8 \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable_trigger=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_output_dir=/var/www/html/profile" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN pecl install rdkafka-4.1.1 \
    && docker-php-ext-enable rdkafka

RUN pecl install zookeeper-0.7.2 \
    && docker-php-ext-enable zookeeper

RUN curl -sS https://getcomposer.org/installer | php -- --1 --install-dir=/usr/local/bin --filename=composer
RUN curl -sS -o /usr/local/bin/n98 https://files.magerun.net/n98-magerun2-3.2.0.phar && chmod +x /usr/local/bin/n98
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

COPY etc/php.ini /usr/local/etc/php/
