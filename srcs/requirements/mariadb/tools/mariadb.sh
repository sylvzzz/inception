#!/bin/bash
set -e

DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_ADMIN_PASSWORD=$(cat /run/secrets/db_admin_password)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_NAME=${DB_NAME}
DB_USER=${DB_USER}
DB_ADMIN=${DB_ADMIN}


mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "No data found, initializing database ..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    mariadbd --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &

    until mariadb-admin --socket=/run/mysqld/mysqld.sock ping >/dev/null 2>&1;
    do
        sleep 1
    done

    echo "Creating database ..."
    mariadb --socket=/run/mysqld/mysqld.sock -u root <<SQL
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
    CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
    CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
    GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
    CREATE USER IF NOT EXISTS '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_ADMIN_PASSWORD';
    GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
SQL

    echo "Restarting database after initialization ..."
    mariadb-admin --socket=/run/mysqld/mysqld.sock -u root -p"$DB_ROOT_PASSWORD" shutdown

fi

exec mariadbd --user=mysql