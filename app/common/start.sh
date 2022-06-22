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
    /usr/bin/envsubst $vars < /app/nginx-site.conf > /app/nginx-site.conf.tmp && mv /app/nginx-site.conf.tmp /app/nginx-site.conf && \
    if [ -f "/app/php.ini" ]; then
      /usr/bin/envsubst $vars < /app/php.ini > /app/php.ini.tmp && mv /app/php.ini.tmp /app/php.ini;
    fi
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

# now run for real
/usr/bin/supervisord -c /app/supervisord.conf
