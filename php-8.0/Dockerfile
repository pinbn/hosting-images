FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1:81/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor bash dos2unix curl wget unzip tzdata gnupg gettext-base && \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/php.list && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x4f4ea0aae5267a6c" | apt-key add - && \
    wget -qO - "https://nginx.org/keys/nginx_signing.key" | apt-key add - && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx php8.0-common memcached php8.0-memcache php8.0-curl php-pear php8.0-cli \
      php8.0-fpm php8.0-gd php8.0-mysql php8.0-opcache php8.0-mbstring php8.0-zip php-maxminddb \
      php8.0-xml php8.0-pgsql php8.0-pspell php8.0-readline php8.0-tidy php8.0-bcmath php8.0-gmp && \
    dpkg -r e2fsprogs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app/common /app
COPY ./app/php /app
RUN ln -s /usr/sbin/php-fpm8.0 /app/php-fpm && dos2unix /app/* && chmod a+x /app/*.sh

CMD ["/bin/bash","/app/start.sh"]