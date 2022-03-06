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
      --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ADD ./deploy/nginx.conf /etc/nginx/sites-enabled/default

ADD "./docker-entrypoint.sh" "/docker-entrypoint.sh"

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]