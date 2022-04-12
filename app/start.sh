#!/bin/sh

# environment replacements
php -n -B /app/functions.php -d short_open_tag=On -f /app/php.ini.php > /app/php.ini

# now run for real
/usr/bin/supervisord -c /app/supervisord.conf