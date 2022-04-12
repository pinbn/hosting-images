FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# specified here for consistency between setups
RUN groupadd -r www-data -g 33 && useradd -r -g www-data -u 33 -d /var/www/html/ www-data

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor procps net-tools bash unzip curl wget composer dos2unix software-properties-common tzdata && \
    wget -qO - https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    add-apt-repository ppa:ondrej/php && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx php7.1-common composer memcached php-memcache php-pear php7.1-cli \
      php7.1-fpm php7.1-gd php-geoip php7.1-json php7.1-mysql php7.1-opcache php7.1-mbstring \
      php7.1-xml php7.1-pgsql php7.1-pspell php7.1-readline php7.1-tidy php7.1-bcmath php7.1-gmp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
RUN ln -s /usr/sbin/php-fpm7.1 /app/php-fpm
CMD ["/bin/sh","/app/start.sh"]