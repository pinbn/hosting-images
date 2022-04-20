FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1:81/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor bash dos2unix curl wget tzdata gnupg gettext-base && \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/php.list && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x4f4ea0aae5267a6c" | apt-key add - && \
    wget -qO - "https://nginx.org/keys/nginx_signing.key" | apt-key add - && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx php7.0-common memcached php7.0-memcache php7.0-curl php-pear php7.0-cli \
      php7.0-fpm php7.0-gd php7.0-geoip php7.0-json php7.0-mysql php7.0-opcache php7.0-mbstring php7.0-zip \
      php7.0-xml php7.0-pgsql php7.0-pspell php7.0-readline php7.0-tidy php7.0-bcmath php7.0-gmp && \
    dpkg -r wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
COPY ./app/php /app
COPY ./app/php-wordpress /app
RUN ln -s /usr/sbin/php-fpm7.0 /app/php-fpm && dos2unix /app/*
CMD ["/bin/bash","/app/start.sh"]