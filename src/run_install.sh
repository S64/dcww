#!/bin/bash
cd /var/www/html

wp core download --locale=ja
wp core config --dbname='wordpress' --dbuser='root' --dbhost='127.0.0.1' --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_DISPLAY', true );
ini_set( 'display_errors', 1 );
PHP

wp db create
wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_USER --admin_password=$WORDPRESS_PASSWORD --admin_email=$WORDPRESS_EMAIL

if $(wp core is-installed); then
  source /opt/run_install_init.sh
fi
