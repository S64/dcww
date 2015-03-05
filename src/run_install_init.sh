#!/bin/bash
cd /var/www/html

wp plugin install error-log-monitor --activate

wp plugin install wp-multibyte-patch
wp plugin install jetpack
wp plugin install google-sitemap-generator
wp plugin install pushpress
wp plugin install wpmandrill
wp plugin install akismet
wp plugin install wordless
