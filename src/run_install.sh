#!/bin/bash
cd /var/www/html

wp core download --locale=$WP_LOCALE
wp core config --dbname='wordpress' --dbuser='root' --dbhost='127.0.0.1' --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_DISPLAY', true );
ini_set( 'display_errors', 1 );
ini_set( 'log_errors', 1 );
ini_set( 'error_log', '/var/log/wordpress/error.log');
define( 'JETPACK_DEV_DEBUG', true );
PHP

wp db create
wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASSWORD --admin_email=$WP_EMAIL

if $(wp core is-installed); then
  source /opt/run_install_init.sh
fi
