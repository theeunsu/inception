#!/bin/sh

# Check and create SSL directory if needed
mkdir -p "$(dirname "$PATH_SSL_KEY")"

# Generate a self-signed key and certificate
if [ ! -f "${PATH_SSL_KEY}" ] || [ ! -f "${PATH_SSL_CERTS}" ]; then
    echo "Generating self-signed SSL certificate..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ${PATH_SSL_KEY} \
    -out ${PATH_SSL_CERTS} \
     -subj "/C=DE/ST=BW/L=Heilbronn/O=42Heilbronn/OU=student/CN=${DOMAIN_NAME}"
    echo "SSL certificate created at ${PATH_SSL_CERTS}"
else
    echo "SSL certificate already exists at ${PATH_SSL_CERTS}"
fi

# Start nginx in the foreground
echo "Starting nginx..."
nginx -g "daemon off;"
 
