FROM alpine:edge as builder

# cjose fails for now it seems
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --no-cache --virtual .build-deps \
  build-base openssl-dev make tcl-dev pcre-dev zlib-dev \
  file perl libexecinfo-dev sed linux-headers libunwind-dev \
  brotli-dev jansson-dev luajit-dev readline-dev geoip-dev \
  git automake libtool autoconf

RUN git clone https://github.com/apache/trafficserver.git \
  && cd trafficserver \
  && autoreconf -if \
  && ./configure --enable-experimental-plugins --disable-hwloc \
  && make \
  && make check
