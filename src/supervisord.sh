#!/bin/bash
chown apache:apache -R /var/www/html
chown apache:apache -R /var/log/wordpress
supervisord --nodaemon
