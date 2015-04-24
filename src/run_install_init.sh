#!/bin/bash
cd /var/www/html

wp plugin install error-log-monitor --activate

wp plugin install theme-check --activate
wp plugin install wp-multibyte-patch
wp plugin install akismet
wp plugin install jetpack

wp plugin install github-updater
wp plugin install wordless

wp theme install twentyten
wp theme install twentyeleven
wp theme install twentytwelve
wp theme install twentythirteen
wp theme install twentyfourteen
wp theme install twentyfifteen

user_init_script='/opt/wordpress/install_init.sh'

if test -r ${user_init_script} -a -f ${user_init_script}; then
  source $user_init_script
fi
