# Nginx image with alpine base image (Penultimate version)
FROM alpine:3.20

# Install necessary packages
RUN apk update && apk add --no-cache nginx openssl

# Copy TLS setup script into the container
COPY ./tools/nginx_init.sh /tmp/nginx_init.sh

# Change permissions of the script
RUN chmod +x /tmp/nginx_init.sh

# Copy custom NGINX configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/conf.d/default.conf /etc/nginx/conf.d/default.conf

# Expose HTTPS port
EXPOSE 443

# Launch the initialization script
CMD ["/tmp/nginx_init.sh"]
