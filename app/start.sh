#!/bin/bash

# environment replacements
if [ -x "$(command -v php)" ]
then
  php -n -B /app/functions.php -d short_open_tag=On -f /app/php.ini.php > /app/php.ini
fi 

if [[ ! -z "${NGINX_UID}" ]]
then
  usermod -u ${NGINX_UID} www-data
  echo "Using specified nginx user ID: ${NGINX_UID}"
fi
if [[ ! -z "${NGINX_GID}" ]]
then
  groupmod -o -g ${NGINX_GID} www-data
  usermod -g ${NGINX_GID} www-data
  echo "Using specified nginx group ID: ${NGINX_GID}"
fi

# now run for real
/usr/bin/supervisord -c /app/supervisord.conf