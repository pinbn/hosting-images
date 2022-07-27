[![Docker](https://github.com/pinbn/hosting-images/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/pinbn/hosting-images/actions/workflows/docker-publish.yml)

# Why in Docker?
We needed a way for some of our clients to run websites using separate versions of PHP (or no PHP at all), and Docker fit the bill perfectly! Later we may add other options (Mono, etc..) that aren't well served by existing community images.

# Volumes
Mount `/var/www/html` to your website's content directory. Normal site logs are emitted via the console/stdout/stderr, but nginx logs not within a site may be contained in `/var/log/nginx`.

# Example Docker compose
There is an example docker compose file showing how to use the container with a Traefik 1 or 2 router. No SSL termination is done within this container.

# Environment Variables
These are the global variables and apply to all images:
  - upload_max_filesize 20M _(but this also applies to php's max POST size as well)_
  - NGINX_LISTEN_PORT 80

There are environment variables you can set for the PHP images (yes, case sensitive, lowercase):
  - php_max_execution_time 300
  - php_input_time 300
  - php_memory_limit 20M
  - php_timezone America/Denver
  - php_allow_url_fopen Off
  - php_smtp_server localhost
  - php_smtp_port 25
  - php_smtp_log /var/log/php.mail.log
  - php_session_handler files
  - php_session_path /tmp
  - php_max_input_vars 1000
  - DEPRECATED: php_upload_max_filesize (now known as `upload_max_filesize`)

For the proxy image, these are the environment variables:
  - proxy_pass `(put a URL here)`
  - proxy_ssl_verify on

For the proxy image, these are the environment variables:
  - redirect_url `(put a URL here)`
  - redirect_code 302
  
For the PHP Wordpress image:
  - `wordpress_is_multisite`: if this environment variable is non-empty/null, we use the alternate multisite compatible config instead.

# Note about ENVIRONMENT VARIABLE naming
Yes, I know, normally environment variables are UPPERCASE.

