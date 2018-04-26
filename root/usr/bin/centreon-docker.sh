#!/bin/bash

sed -e "s/?date.timezone=.*/date.timezone=$PHP_DATE_TIMEZONE/g" /etc/php.ini

supervisord --configuration=/etc/supervisord.conf