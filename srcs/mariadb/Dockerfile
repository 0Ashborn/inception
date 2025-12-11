FROM debian:bullseye

RUN apt update -y && apt install -y mariadb-server mariadb-client

COPY ./config/db.cnf /etc/mysql/my.cnf

COPY ./tools/init_db.sh /usr/local/bin/init_db.sh
RUN chmod +x /usr/local/bin/init_db.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init_db.sh"]

CMD ["mysqld_safe"]
