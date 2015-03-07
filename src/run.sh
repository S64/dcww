#!/bin/bash
cd /var/www/html
sleep 5

if ! $(wp core is-installed); then
  source /opt/run_install.sh
fi
