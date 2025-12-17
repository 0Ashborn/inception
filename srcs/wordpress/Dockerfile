FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y wget php-fpm php-mysql curl php-cli php-mbstring php-xml php-curl mariadb-client ca-certificates openssl && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -p /var/www/wordpress
WORKDIR /var/www/wordpress

RUN curl -sSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

COPY ./config/wordpress.conf /etc/php/7.4/fpm/pool.d/wordpress.conf

RUN if [ -f /etc/php/7.4/fpm/pool.d/www.conf ]; then rm /etc/php/7.4/fpm/pool.d/www.conf; fi

COPY ./tools/setup-wordpress.sh /usr/local/bin/setup-wordpress.sh
RUN chmod +x /usr/local/bin/setup-wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup-wordpress.sh"]
