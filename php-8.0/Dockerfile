FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor procps net-tools bash unzip curl wget composer dos2unix software-properties-common tzdata && \
    wget -qO - https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    add-apt-repository ppa:ondrej/php && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx php8.0-common composer memcached php-memcache php-pear php8.0-cli \
      php8.0-fpm php8.0-gd php-geoip php-json php8.0-mysql php8.0-opcache php8.0-mbstring \
      php8.0-xml php8.0-pgsql php8.0-pspell php8.0-readline php8.0-tidy php8.0-bcmath php8.0-gmp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
RUN ln -s /usr/sbin/php-fpm8.0 /app/php-fpm
CMD ["/bin/sh","/app/start.sh"]