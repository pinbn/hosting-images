
  replace_from_env "proxy_pass" "${proxy_pass:-"https://google.com"}"
  replace_from_env "proxy_ssl_verify" "${proxy_ssl_verify:="on"}"
  replace_from_env "proxy_inject_upstream_host" "${proxy_inject_upstream_host:-"\$host"}"
  