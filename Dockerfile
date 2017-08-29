FROM alpine:3.6 as builder

ARG VERSION=7.1.0
ENV ATS_VERSION $VERSION

RUN  apk update \
  && apk upgrade \
  && apk add --virtual .build-deps \
     build-base libressl-dev make tcl-dev pcre-dev zlib-dev ca-certificates \
     file perl libexecinfo-dev sed linux-headers wget

RUN  cd /tmp \
  && wget -q \
     http://www-us.apache.org/dist/trafficserver/trafficserver-${ATS_VERSION}.tar.bz2 \
     https://github.com/apache/trafficserver/pull/1762.patch \
  && tar -xjf trafficserver-$ATS_VERSION.tar.bz2 \
  && cd trafficserver-$ATS_VERSION \
  # see https://github.com/apache/trafficserver/pull/1762 \
  && patch -p1 < ../1762.patch \
  # see https://github.com/apache/trafficserver/issues/2444 \
  && sed -ie 's/#include <wait.h>/#include <sys\/wait.h>/' lib/ts/ink_platform.h \
  # AR: avoid annoying outut -- doesn't seem to work \
  && AR_FLAGS=cr ./configure --enable-experimental-plugins --disable-hwloc \
  # @TODO: https://github.com/apache/trafficserver/issues/2445 \
  # @TODO: fix <sys/sysctl.h> -- should be <linux/sysctl.h> if used \
  && make