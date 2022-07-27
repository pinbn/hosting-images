#!/bin/bash
set +a
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
export -f replace_from_env
set -a
