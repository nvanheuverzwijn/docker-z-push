#!/usr/bin/env bash

chown -R www-data:www-data /var/log/z-push /var/lib/z-push

service apache2 start
service php5-fpm start

service apache2 status
service php5-fpm status
