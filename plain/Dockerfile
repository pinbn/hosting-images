FROM ubuntu:20.04
EXPOSE 80
HEALTHCHECK --interval=15s --timeout=30s --retries=3 CMD curl --fail http://127.0.0.1:81/noop || exit 1
VOLUME /var/www/html
VOLUME /var/log/nginx

# install our deps
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y supervisor curl wget software-properties-common tzdata && \
    wget -qO - https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    echo "deb https://nginx.org/packages/mainline/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y nginx && \
    dpkg -r wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app /app
# override the PHP bits and remove any PHP "scripts"
COPY ./app/plain-overrides /app 
RUN rm /app/*php*

CMD ["/bin/sh","/app/start.sh"]