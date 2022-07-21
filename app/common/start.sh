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
    for i in `ls /app/*.conf /app/*.ini` \
      do \
        /usr/bin/envsubst $vars < $i > $i.tmp && mv $i.tmp $i && \
      done
  )
}

# Global:
replace_from_env "upload_max_filesize" "${upload_max_filesize:="20M"}"

# If proxy image:
if [ -f "/app/proxy.ini" ]
then
  replace_from_env "proxy_pass" "${proxy_pass:-"https://google.com"}"
  replace_from_env "proxy_ssl_verify" "${proxy_ssl_verify:="on"}"
  replace_from_env "proxy_inject_upstream_host" "${proxy_inject_upstream_host:-"\$host"}"
fi

# If redirect image:
if [ -f "/app/redirect.ini" ]
then
  replace_from_env "redirect_url" "${redirect_url:-"https://google.com"}"
  replace_from_env "redirect_code" "${redirect_code:="302"}"
fi

# If PHP image:
if [ -f "/app/php.ini" ]
then
  replace_from_env "php_max_execution_time" "${php_max_execution_time:="300"}"
  replace_from_env "php_input_time" "${php_input_time:="300"}"
  replace_from_env "php_memory_limit" "${php_memory_limit:="20M"}"
  replace_from_env "php_timezone" "${php_timezone:="America/Denver"}"
  replace_from_env "php_allow_url_fopen" "${php_allow_url_fopen:="Off"}"
  replace_from_env "php_smtp_server" "${php_smtp_server:="localhost"}"
  replace_from_env "php_smtp_port" "${php_smtp_port:="25"}"
  replace_from_env "php_smtp_log" "${php_smtp_log:="/var/log/php.mail.log"}"
  replace_from_env "php_session_handler" "${php_session_handler:="files"}"
  replace_from_env "php_session_path" "${php_session_path:="/tmp"}"
  replace_from_env "php_max_input_vars" "${php_max_input_vars:="1000"}"
fi 

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
  . /app/init.sh
fi

/usr/bin/supervisord -c /app/supervisord.conf
