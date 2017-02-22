FROM ravihuang/gerrit

MAINTAINER ravih <ravi.huang@gmail.com>

ENV ZUUL_HOME /var/zuul
ENV ZUUL_GIT ${ZUUL_HOME}/git
ENV ZUUL_USER zuul

COPY start_zuul.sh /docker-entrypoint-init.d/
COPY gerrit-entrypoint.sh /

RUN apk add python python-dev py-pip gcc libc-dev && \
    pip install zuul && \
    su-exec ${ZUUL_USER} mkdir /etc/zuul && \
    su-exec ${ZUUL_USER} mkdir -p /var/zuul/git && \
    apk del gcc 

RUN adduser -D -h "${ZUUL_HOME}" -g "Zuul User" -s /sbin/nologin "${ZUUL_USER}"
COPY zuul.conf /etc/zuul/
