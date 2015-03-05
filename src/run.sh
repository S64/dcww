#!/bin/bash
supervisord
cd /var/www/html

if ! $(wp core is-installed); then
  source /opt/run_install.sh
fi
