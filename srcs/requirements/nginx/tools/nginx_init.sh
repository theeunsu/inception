#!/bin/sh

# Set default values if variables are not provided
: "${PATH_SSL_KEY:=/etc/nginx/ssl/server.key}"
: "${PATH_SSL_CERT:=/etc/nginx/ssl/server.crt}"
: "${DOMAIN_NAME:=localhost}"

# Check and create SSL directory if needed
mkdir -p "$(dirname "$PATH_SSL_KEY")"

# Generate a self-signed key and certificate if not already present
if [ ! -f "$PATH_SSL_KEY" ] || [ ! -f "$PATH_SSL_CERT" ]; then
	echo "Generating self-signed SSL certificate..."
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout "$PATH_SSL_KEY" \
	-out "$PATH_SSL_CERT" \
	-subj "/C=DE/ST=BW/L=Heilbronn/O=42Heilbronn/OU=student/CN=${DOMAIN_NAME}"
	echo "SSL certificate created at $PATH_SSL_CERT"
else
	echo "SSL certificate already exists at $PATH_SSL_CERT"
fi

# Start nginx in the foreground
echo "Starting nginx..."
nginx -g "daemon off;"

# A daemon is a process that runs in the background.
# In this case, we disable daemon mode to keep the process running in the foreground.
# In a Docker container, the main process must run in the foreground.
# If it runs in the background, the container will stop.
