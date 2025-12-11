FROM debian:bullseye

# Install nginx and openssl (no credentials here)
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends nginx openssl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create dirs expected by config
RUN mkdir -p /etc/nginx/sslconfig /etc/ssl/private /etc/ssl/certs

WORKDIR /tmp/build

# Copy configs and scripts
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/ssl-params.conf /etc/nginx/sslconfig/ssl-params.conf
COPY ./tools/generate_ssl.sh /usr/local/bin/generate_ssl.sh

RUN chmod +x /usr/local/bin/generate_ssl.sh

EXPOSE 443

# Entrypoint will create certs if needed then run nginx in foreground.
ENTRYPOINT ["/usr/local/bin/generate_ssl.sh"]
