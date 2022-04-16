FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1:81/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor bash dos2unix curl wget tzdata gnupg && \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/php.list && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x4f4ea0aae5267a6c" | apt-key add - && \
    wget -qO - "https://nginx.org/keys/nginx_signing.key" | apt-key add - && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx php7.1-common memcached php7.1-memcache php-pear php7.1-cli \
      php7.1-fpm php7.1-gd php7.1-geoip php7.1-json php7.1-mysql php7.1-opcache php7.1-mbstring \
      php7.1-xml php7.1-pgsql php7.1-pspell php7.1-readline php7.1-tidy php7.1-bcmath php7.1-gmp && \
    dpkg -r wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
COPY ./app/php /app
RUN ln -s /usr/sbin/php-fpm7.1 /app/php-fpm && dos2unix /app/*
CMD ["/bin/bash","/app/start.sh"]