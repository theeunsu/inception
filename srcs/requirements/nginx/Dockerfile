# Description: Nginx image with alpine base image (Penultimate version)
From alpine:3.20.3

# Install necessary packages
RUN apk update && apd add --no-cache nginx openssl

# Create SSL certificate directory and generate a self-signed certificate
EXPOSE 443
