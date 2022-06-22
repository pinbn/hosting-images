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
    apt-get install -y nginx php7.2-common memcached php7.2-memcache php7.2-curl php-pear php7.2-cli \
      php7.2-fpm php7.2-gd php7.2-geoip php7.2-json php7.2-mysql php7.2-opcache php7.2-mbstring php7.2-zip \
      php7.2-xml php7.2-pgsql php7.2-pspell php7.2-readline php7.2-tidy php7.2-bcmath php7.2-gmp && \
    dpkg -r wget e2fsprogs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app/common /app
COPY ./app/php /app
RUN ln -s /usr/sbin/php-fpm7.2 /app/php-fpm && dos2unix /app/*
CMD ["/bin/bash","/app/start.sh"]