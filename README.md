# PHP in Docker
We needed a way for some of our clients to run websites using separate versions of PHP, and Docker fit the bill perfectly!

# Volumes
Mount `/var/www/html` to your website's content directory. Normal site logs are emitted via the console/stdout/stderr, but nginx logs not within a site may be contained in `/var/log/nginx`.

# Example Docker compose
There is an example docker compose file showing how to use the container with a Traefik 1 or 2 router. No SSL termination is done within this container.
