#!/bin/bash

# environment replacements
replace_from_env () {
  var_name=$1
  var_value=$2
  printf -v "$var_name" '%s' "${var_value}"
  (
    echo "${var_name} = '${var_value}'"
    export "${var_name}" && \
    vars="'\$${var_name}'" && \
    for i in `ls /app/*.conf /app/*.ini`; \
      do \
        /usr/bin/envsubst $vars < $i > $i.tmp && mv $i.tmp $i; \
      done
  )
}

# first any pre-initialization script (may set default variables)
if [ -f "/app/preinit.sh" ]
then
  . /app/preinit.sh
fi

# Global:
replace_from_env "NGINX_LISTEN_PORT" "${NGINX_LISTEN_PORT:="80"}"
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
if [ -f "/app/postinit.sh" ]
then
  . /app/postinit.sh
fi

/usr/bin/supervisord -c /app/supervisord.conf
