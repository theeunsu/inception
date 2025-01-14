# Use Alpine Linux as the base image
FROM alpine:3.20

# Define PHP version as an environment variable for flexibility
ENV PHP_VERSION=82

# Update and install necessary packages
RUN apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-phar \
    wget \
    unzip \
    mariadb-client && \
    # Configure PHP-FPM to listen on port 9000
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    ln -s /usr/bin/php${PHP_VERSION} /usr/bin/php && \
	# Clean up APK cache to reduce image size
    rm -rf /var/cache/apk/*

# Copy the WordPress initialization script into the container
COPY ./tools/wordpress_init.sh /tmp/wordpress_init.sh

# Make the initialization script executable
RUN chmod +x /tmp/wordpress_init.sh && \
    # Download and extract the latest WordPress files
    wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    # Move WordPress files to the appropriate directory
    mkdir -p /var/www/wordpress && \
    cp -rf wordpress/* /var/www/wordpress && \
    # Clean up temporary files
    rm -rf wordpress latest.zip

# Expose the PHP-FPM port
EXPOSE 9000

# Set the working directory to the WordPress directory
WORKDIR /var/www/wordpress

# Run the initialization script as the container's entry point
ENTRYPOINT ["/tmp/wordpress_init.sh"]
