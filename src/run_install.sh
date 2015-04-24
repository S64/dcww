#!/bin/bash
cd /var/www/html

if [ -n "$WP_VERSION" ]; then
  wp core download --version="'${WP_VERSION}'" --locale=$WP_LOCALE
else
  wp core download --locale=$WP_LOCALE
fi

wp core config --dbname='wordpress' --dbuser='root' --dbhost='127.0.0.1' --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_DISPLAY', true );
ini_set( 'display_errors', 1 );
ini_set( 'log_errors', 1 );
ini_set( 'error_log', '/var/log/wordpress/error.log');
define( 'JETPACK_DEV_DEBUG', true );
PHP

wp db create

install_eval="--url='${WP_URL}' --title='${WP_TITLE}' --admin_user='${WP_USER}' --admin_password='${WP_PASSWORD}' --admin_email='${WP_EMAIL}'"
if ! [ $WP_ALLOW_MULTISITE ]; then
  install_eval="wp core install ${install_eval}"
else
  install_eval="wp core multisite-install ${install_eval}"
  if [ $WP_MULTISITE_SUBDOMAINS ]; then
    install_eval="${install_eval} --subdomains"
  fi
fi
eval $install_eval


if $(wp core is-installed); then
  source /opt/run_install_init.sh
fi
