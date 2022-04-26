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
    apt-get install -y nginx php5.6-common memcached php5.6-memcache php5.6-curl php-pear php5.6-cli \
      php5.6-fpm php5.6-gd php5.6-geoip php5.6-json php5.6-mysql php5.6-opcache php5.6-mbstring php5.6-zip \
      php5.6-xml php5.6-pgsql php5.6-pspell php5.6-readline php5.6-tidy php5.6-bcmath php5.6-gmp && \
    dpkg -r wget e2fsprogs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
COPY ./app/php /app
RUN ln -s /usr/sbin/php-fpm5.6 /app/php-fpm && dos2unix /app/*
CMD ["/bin/bash","/app/start.sh"]