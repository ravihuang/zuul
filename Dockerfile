FROM ravihuang/gerrit

MAINTAINER ravih <ravi.huang@gmail.com>

COPY start_zuul.sh /docker-entrypoint-init.d/
COPY gerrit-entrypoint.sh /

RUN apk add python python-dev py-pip gcc libc-dev && \
    pip install zuul && \
    mkdir /etc/zuul && \
    apk del gcc 
    
COPY zuul.conf /etc/zuul/
