#!/bin/sh

sed -i "s#;date.timezone =.*#date.timezone = \"$PHP_DATE_TIMEZONE\"#g" /etc/php.ini | grep date.timezone /etc/php.ini

exec "$@"