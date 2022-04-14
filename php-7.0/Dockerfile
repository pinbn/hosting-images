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
    apt-get install -y nginx php7.0-common composer memcached php-memcache php-pear php7.0-cli \
      php7.0-fpm php7.0-gd php-geoip php7.0-json php7.0-mysql php7.0-opcache php7.0-mbstring \
      php7.0-xml php7.0-pgsql php7.0-pspell php7.0-readline php7.0-tidy php7.0-bcmath php7.0-gmp && \
    dpkg -r wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
RUN sed -i '/## LOCATION BLOCKS ##/  include /app/nginx-php.conf;/' /app/nginx.conf
RUN ln -s /usr/sbin/php-fpm7.0 /app/php-fpm
CMD ["/bin/sh","/app/start.sh"]