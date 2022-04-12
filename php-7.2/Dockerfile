FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# specified here for consistency between setups
RUN (delgroup www-data || true) && \
    groupadd -r www-data -g 33 && \
    useradd -r -g www-data -u 33 -d /var/www/html/ www-data

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor procps net-tools bash unzip curl wget composer dos2unix software-properties-common tzdata && \
    wget -qO - https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    add-apt-repository ppa:ondrej/php && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx php7.2-common composer memcached php-memcache php-pear php7.2-cli \
      php7.2-fpm php7.2-gd php-geoip php7.2-json php7.2-mysql php7.2-opcache php7.2-mbstring \
      php7.2-xml php7.2-pgsql php7.2-pspell php7.2-readline php7.2-tidy php7.2-bcmath php7.2-gmp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
RUN ln -s /usr/sbin/php-fpm7.2 /app/php-fpm    
CMD ["/bin/sh","/app/start.sh"]