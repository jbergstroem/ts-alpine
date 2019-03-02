# Traffic Server for Docker

This repository aims to build a small and relocatable [Apache Traffic Server][ats] suitable for Containerized environments.

## Current state

Builds current HEAD but [tests are failing](https://github.com/apache/trafficserver/issues/5108). The ambition is to prepare 9.0.x for an Alpine environment and later land it as part of the alpine linux package repository.

Notes:

-   missing cjose binding for experimental plugins ([wip to land in alpine here](https://github.com/alpinelinux/aports/pull/6526))
-   requires three patches, all pending upstream ([\#5107](https://github.com/apache/trafficserver/pull/5107), [\#5105](https://github.com/apache/trafficserver/pull/5105), [\#5104](https://github.com/apache/trafficserver/pull/5104))

[ats]: http://trafficserver.apache.org/
