#!/bin/bash

# environment replacements
replace_from_env () {
  var_name=$1
  default_value=$2
  [[ ! -z "${!var_name}" ]] || printf -v "$var_name" '%s' "${default_value}"
  (
    echo "${var_name} = '${!var_name}'"
    export "${var_name}" && \
    vars="'\$${var_name}'" && \
    # echo "envsubst $vars < nginx-site.conf > nginx-site.conf.tmp" && \
    /usr/bin/envsubst $vars < /app/nginx-site.conf > /app/nginx-site.conf.tmp && mv /app/nginx-site.conf.tmp /app/nginx-site.conf && \
    if [ -f "/app/php.ini" ]; then
      /usr/bin/envsubst $vars < /app/php.ini > /app/php.ini.tmp && mv /app/php.ini.tmp /app/php.ini;
    fi
  )
}

# used by nginx and PHP, so always render
replace_from_env "php_upload_max_filesize" "20M"

if [ -x "$(command -v php)" ]
then
  replace_from_env "php_max_execution_time" "300"
  replace_from_env "php_input_time" "300"
  replace_from_env "php_memory_limit" "20M"
  replace_from_env "php_timezone" "America/Denver"
  replace_from_env "php_allow_url_fopen" "Off"
  replace_from_env "php_smtp_server" "localhost"
  replace_from_env "php_smtp_port" "25"
  replace_from_env "php_smtp_log" "/var/log/php.mail.log"
  replace_from_env "php_session_handler" "files"
  replace_from_env "php_session_path" "/tmp"
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
