[![Docker](https://github.com/pinbn/hosting-images/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/pinbn/hosting-images/actions/workflows/docker-publish.yml)

# Why in Docker?
We needed a way for some of our clients to run websites using separate versions of PHP (or no PHP at all), and Docker fit the bill perfectly! Later we may add other options (Mono, etc..) that aren't well served by existing community images.

# Volumes
Mount `/var/www/html` to your website's content directory. Normal site logs are emitted via the console/stdout/stderr, but nginx logs not within a site may be contained in `/var/log/nginx`.

# Example Docker compose
There is an example docker compose file showing how to use the container with a Traefik 1 or 2 router. No SSL termination is done within this container.

# Environment Variables
There are environment variables you can set for the PHP images (yes, case sensitive, lowercase):
  - php_max_execution_time 300
  - php_input_time 300
  - php_memory_limit 20M
  - php_upload_max_filesize 20M
  - php_timezone America/Denver
  - php_allow_url_fopen Off
  - php_smtp_server localhost
  - php_smtp_port 25
  - php_smtp_log /var/log/php.mail.log
  - php_session_handler files
  - php_session_path /tmp
