#!/bin/bash
set -e

MYSQL_DIR="/var/lib/mysql"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld


# Detect first run
if [ ! -d "$MYSQL_DIR/mysql" ]; then
    echo "[MariaDB] First run — initializing..."

    # Prepare DB structure
    mysql_install_db --user=mysql --ldata="$MYSQL_DIR" > /dev/null

    echo "[MariaDB] Starting temporary MariaDB instance..."
    mariadbd --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
    TEMP_PID=$!

    # Wait for temp server
    until mariadb -u root --socket=/run/mysqld/mysqld.sock -e "SELECT 1" &>/dev/null; do
        sleep 1
    done

    echo "[MariaDB] Applying initial SQL..."
    mariadb --socket=/run/mysqld/mysqld.sock <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    echo "[MariaDB] Stopping temporary server..."
    mariadb-admin --socket=/run/mysqld/mysqld.sock shutdown

    wait "$TEMP_PID" 2>/dev/null || true
else
    echo "[MariaDB] Existing database — skipping initialization."
fi

echo "[MariaDB] Starting MariaDB in foreground..."
exec mariadbd --user=mysql
