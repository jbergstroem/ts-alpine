FROM alpine:edge as builder

ARG ATS_VERSION=8.0.2

RUN  apk add --no-cache --virtual .build-deps \
     build-base openssl-dev make tcl-dev pcre-dev zlib-dev \
     file perl libexecinfo-dev sed linux-headers libunwind-dev \
     brotli-dev jansson-dev luajit-dev readline-dev geoip-dev

RUN wget http://www-us.apache.org/dist/trafficserver/trafficserver-${ATS_VERSION}.tar.bz2 \
  && tar -xjf trafficserver-$ATS_VERSION.tar.bz2 \
  && cd trafficserver-$ATS_VERSION \
  && ./configure --enable-experimental-plugins --disable-hwloc \
  && make
