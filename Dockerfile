FROM alpine:edge as builder

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache --virtual .build-deps \
  build-base openssl-dev make tcl-dev pcre-dev zlib-dev \
  file perl libexecinfo-dev sed linux-headers libunwind-dev \
  brotli-dev jansson-dev luajit-dev readline-dev geoip-dev \
  git automake libtool autoconf 

RUN git clone https://github.com/apache/trafficserver.git \
  && cd trafficserver \
  && wget \
    https://patch-diff.githubusercontent.com/raw/apache/trafficserver/pull/5104.diff \
    https://patch-diff.githubusercontent.com/raw/apache/trafficserver/pull/5105.diff \
    https://patch-diff.githubusercontent.com/raw/apache/trafficserver/pull/5107.diff \
  && patch -p1 < 5104.diff && patch -p1 < 5105.diff && patch -p1 < 5107.diff \
  && autoreconf -if \
  && ./configure --enable-experimental-plugins --disable-hwloc \
  && make check
