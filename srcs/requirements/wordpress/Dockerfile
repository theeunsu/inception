# Wordpress image with alpine base image (Penultimate version) 
FROM alpine:3.20

# Use the penultimate version of PHP
ENV PHP_VERSION=82
ENV PHP_FPM_PORT=9000

# Install PHP, PHP extensions, other necessary packages
RUN apk update && apk add --no-cache \
	php${PHP_VERSION} \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-xml \
	php${PHP_VERSION}-mbstring \
	php${PHP_VERSION}-phar \
	wget \
	unzip \
	mariadb-client && \
	
