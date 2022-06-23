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
    apt-get install -y nginx php8.1-common memcached php8.1-memcache php8.1-curl php-pear php8.1-cli \
      php8.1-fpm php8.1-gd php8.1-mysql php8.1-opcache php8.1-mbstring php8.1-zip \
      php8.1-xml php8.1-pgsql php8.1-pspell php8.1-readline php8.1-tidy php8.1-bcmath php8.1-gmp && \
    dpkg -r wget e2fsprogs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app/common /app
COPY ./app/php /app
COPY ./app/php-wordpress /app
RUN ln -s /usr/sbin/php-fpm8.1 /app/php-fpm && dos2unix /app/* && chmod a+x /app/*.sh

CMD ["/bin/bash","/app/start.sh"]