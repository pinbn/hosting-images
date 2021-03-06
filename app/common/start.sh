#!/bin/bash

# environment replacements
source /app/functions.sh

# ensure they exist so we don't error out below if we aren't using pre/post init scripts
mkdir -p /app /app/preinit /app/postinit
chmod -f a+rx /app/preinit/*.sh /app/postinit/*.sh

# first any pre-initialization scripts (may set default variables)
if [ "$(ls -A /app/preinit/*.sh)" ]; then
  for i in `ls /app/preinit/*.sh`; do source $i; done
fi

# Global:
replace_from_env "NGINX_LISTEN_PORT" "${NGINX_LISTEN_PORT:="80"}"
replace_from_env "NGINX_REAL_IP_HEADER" "${NGINX_REAL_IP_HEADER:="X-Forwarded-For"}"
replace_from_env "upload_max_filesize" "${upload_max_filesize:="20M"}"

# set user/group IDs on container:
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

# now run for real, first any initialization script and then the real deal
if [ -f "/app/init.sh" ]
then
  echo "Using /app/init.sh is DEPRECATED - please use preinit.sh or postinit.sh instead!"
  . /app/init.sh
fi
if [ "$(ls -A /app/postinit/*.sh)" ]; then
  for i in `ls /app/postinit/*.sh`; do source $i; done
fi

/usr/bin/supervisord -c /app/supervisord.conf
