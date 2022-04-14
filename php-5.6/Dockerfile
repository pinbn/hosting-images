FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1:81/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor curl wget composer software-properties-common tzdata && \
    wget -qO - https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    add-apt-repository ppa:ondrej/php && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx php5.6-common composer memcached php-memcache php-pear php5.6-cli \
      php5.6-fpm php5.6-gd php-geoip php5.6-json php5.6-mysql php5.6-opcache php5.6-mbstring \
      php5.6-xml php5.6-pgsql php5.6-pspell php5.6-readline php5.6-tidy php5.6-bcmath php5.6-gmp && \
    dpkg -r wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
RUN ln -s /usr/sbin/php-fpm5.6 /app/php-fpm
CMD ["/bin/sh","/app/start.sh"]