#!/bin/bash
set -e

DB_PASSWORD=$(cat /run/secrets/db_password)

if [ ! -f /var/www/html/wp-config.php ]; then
    curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    cat > /var/www/html/wp-config.php <<EOF
<?php
define('DB_NAME', '$DB_NAME');
define('DB_USER', '$DB_USER');
define('DB_PASSWORD', '$DB_PASSWORD');
define('DB_HOST', 'mariadb:3306');
\$table_prefix = 'wp_';
require_once ABSPATH . 'wp-settings.php';
EOF

fi

chown -R www-data:www-data /var/www/html

# foreground; without FPM daemonizes and container dies
exec php-fpm8.2 -F