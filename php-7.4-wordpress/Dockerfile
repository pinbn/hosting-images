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
    apt-get install -y nginx php7.4-common memcached php7.4-memcache php7.4-curl php-pear php7.4-cli \
      php7.4-fpm php7.4-gd php7.4-geoip php7.4-json php7.4-mysql php7.4-opcache php7.4-mbstring php7.4-zip \
      php7.4-xml php7.4-pgsql php7.4-pspell php7.4-readline php7.4-tidy php7.4-bcmath php7.4-gmp && \
    dpkg -r wget e2fsprogs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
COPY ./app/php /app
COPY ./app/php-wordpress /app
RUN ln -s /usr/sbin/php-fpm7.4 /app/php-fpm && dos2unix /app/*
CMD ["/bin/bash","/app/start.sh"]