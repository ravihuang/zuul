#!/usr/bin/env sh
set -e

set_gerrit_config() {
  su-exec ${GERRIT_USER} git config -f "${GERRIT_SITE}/etc/gerrit.config" "$@"
}
set_secure_config() {
  su-exec ${GERRIT_USER} git config -f "${GERRIT_SITE}/etc/secure.config" "$@"
}
export WEBURL = "http://127.0.0.1:8080"
export DATABASE_TYPE = "postgresql"
export 

/gerrit-entrypoint.sh

set_gerrit_config plugin.events-log.storeDriver "org.postgresql.Driver"
set_gerrit_config plugin.events-log.storeUrl "jdbc:${DATABASE_TYPE}://${DB_PORT_5432_TCP_ADDR}/${DB_ENV_POSTGRES_DB}"                                     
set_gerrit_config plugin.events-log.storeUsername "${DB_ENV_POSTGRES_USER}"                                                                                            
set_secure_config plugin.events-log.storePassword "${DB_ENV_POSTGRES_PASSWORD}" 
set_gerrit_config httpd.listenUrl "proxy-http://*:8080/"

set_gerrit_config gitweb.type "gitweb"
[ -z "${GITWEB_IP}" ] ||  set_gerrit_config gitweb.url "http://${GITWEB_IP}/gitweb/gitweb.cgi"
