#!/bin/bash
cd /var/www/html
sleep 5

res=`wp core is-installed`
ret=$?

echo $res
echo $ret

if ! [ $ret -eq 0 ]; then
  source /opt/run_install.sh
fi
