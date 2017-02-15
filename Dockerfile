FROM openfrontier/gerrit

MAINTAINER ravih <ravi.huang@gmail.com>
RUN apk add nginx apache2-utils && \
    htpasswd -b /etc/nginx/users admin passwd
    git config --global core.quotepath false && \
    git config --global i18n.logoutputencoding utf8 && \
    git config --global i18n.commitencoding utf8

COPY nginx.conf /etc/nginx/
