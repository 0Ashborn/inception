FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends nginx openssl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/sslconfig /etc/ssl/private /etc/ssl/certs

WORKDIR /tmp/build

COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/ssl-params.conf /etc/nginx/sslconfig/ssl-params.conf
COPY ./tools/generate_ssl.sh /usr/local/bin/generate_ssl.sh

RUN chmod +x /usr/local/bin/generate_ssl.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/generate_ssl.sh"]
