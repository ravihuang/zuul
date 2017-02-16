FROM openfrontier/gerrit

MAINTAINER ravih <ravi.huang@gmail.com>

COPY nginx.conf /etc/nginx/
COPY start_nginx.sh /docker-entrypoint-init.d/
COPY gerrit-entrypoint.sh /

RUN apk add nginx apache2-utils && \
    htpasswd -bc /etc/nginx/users admin passwd && \
    git config --global core.quotepath false && \
    git config --global i18n.logoutputencoding utf8 && \
    git config --global i18n.commitencoding utf8 && \
    chmod +x /gerrit*.sh
