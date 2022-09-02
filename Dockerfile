FROM phusion/baseimage:focal-1.0.0

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list && \
      apt-get update && apt-get install -y \
      curl \
      fcgiwrap \
      spawn-fcgi \
      unzip \
      vim \
      wget \
      cpanminus \
      build-essential \
      nginx \
      tini \
      --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ADD ./deploy/nginx.conf /etc/nginx/sites-enabled/default

ADD "./docker-entrypoint.sh" "/docker-entrypoint.sh"

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]