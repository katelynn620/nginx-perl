FROM phusion/baseimage:bionic-1.0.0

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list && \
      apt-get update && apt-get install -y \
      curl \
      fcgiwrap \
      unzip \
      vim \
      wget \
      cpanminus \
      nginx \
      --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ADD ./deploy/nginx.conf /etc/nginx/sites-enabled/default

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ADD "./docker-entrypoint.sh" "/docker-entrypoint.sh"

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]