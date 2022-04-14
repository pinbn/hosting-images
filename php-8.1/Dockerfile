FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1:81/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor wget composer software-properties-common tzdata && \
    wget -qO - https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    add-apt-repository ppa:ondrej/php && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx php8.1-common composer memcached php-memcache php-pear php8.1-cli \
      php8.1-fpm php8.1-gd php-geoip php-json php8.1-mysql php8.1-opcache php8.1-mbstring \
      php8.1-xml php8.1-pgsql php8.1-pspell php8.1-readline php8.1-tidy php8.1-bcmath php8.1-gmp && \
    dpkg -r wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
RUN sed -i '/## LOCATION BLOCKS ##/  include /app/nginx-php.conf;/' /app/nginx.conf
RUN ln -s /usr/sbin/php-fpm8.1 /app/php-fpm
CMD ["/bin/sh","/app/start.sh"]