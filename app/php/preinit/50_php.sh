#!/bin/bash
source /app/functions.sh

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
  replace_from_env "PHP_ERROR_LOG" "${PHP_ERROR_LOG:="syslog"}"
