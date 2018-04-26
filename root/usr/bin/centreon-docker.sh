#!/bin/bash

sed -e 's/?date.timezone=.*/date.timezone=Europe\/Paris/g' /etc/php.ini

supervisord --configuration=/etc/supervisord.conf