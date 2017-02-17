FROM openfrontier/gerrit

MAINTAINER ravih <ravi.huang@gmail.com>

COPY nginx.conf /etc/nginx/
COPY fcgi-run /etc/init.d/
COPY spawn-fcgi /usr/bin/
COPY start_nginx.sh /docker-entrypoint-init.d/
COPY pg_config.sh /docker-entrypoint-init.d/

RUN apk add nginx apache2-utils fcgi fcgiwrap && \
    htpasswd -bc /var/gerrit/users admin passwd && \
    git config --global core.quotepath false && \
    git config --global i18n.logoutputencoding utf8 && \
    git config --global i18n.commitencoding utf8 && \
    chmod +x /etc/init.d/fcgi-run && \
    chmod +x /usr/bin/spawn-fcgi
