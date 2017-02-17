FROM openfrontier/gerrit

MAINTAINER ravih <ravi.huang@gmail.com>

COPY nginx.conf /etc/nginx/
COPY start_apache.sh /docker-entrypoint-init.d/
COPY gerrit-entrypoint.sh /
COPY fcgi-run /etc/init.d/
COPY spawn-fcgi /usr/bin/

RUN apk add apache2 apache2-utils fcgi fcgiwrap && \
    htpasswd -bc /var/gerrit/users admin passwd && \
    git config --global core.quotepath false && \
    git config --global i18n.logoutputencoding utf8 && \
    git config --global i18n.commitencoding utf8 && \
    chmod +x /gerrit*.sh && chmod +x /etc/init.d/fcgi-run && \
    chmod +x /usr/bin/spawn-fcgi
