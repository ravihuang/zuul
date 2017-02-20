# Zuul/Gerrit Docker image
 The Gerrit code review system with PostgreSQL, Nginx, Gitweb, Zuul and OpenLDAP integration supported.
 This image is based on https://github.com/ravihuang/gerrit_cn

## Container Quickstart
  1. Initialize and start gerrit.
     ```
     # mkdir ~/gerrit_volume
     # docker run --name pg-gerrit -p 5432:5432 -e POSTGRES_USER=gerrit2 -e POSTGRES_PASSWORD=gerrit -e POSTGRES_DB=reviewdb -d postgres
     # docker run --name gerrit --link pg-gerrit:db -v /~/gerrit_volume/:/var/gerrit/review_site -p 80:80 -p 29418:29418 -e GITWEB_IP=<your ip> -e AUTH_TYPE=HTTP -d ravihuang/gerrit
     ```
     
  2. Open your browser to 
  
      `http://<your ip>`
     
  3. Default using HTTP authentication type
  
     `u/p: admin/passwd`
     
## Use another container as the gerrit site storage.
  1. Create a volume container.

    `docker run --name gerrit_volume ravihuang/gerrit echo "Gerrit volume container."`

  2. Initialize and start gerrit using volume created above.

    `docker run -d --volumes-from gerrit_volume -p 8080:8080 -p 29418:29418 ravihuang/gerrit`


    docker run \
    --name gerrit \
    --link pg-gerrit:db \
    -p 8080:8080 \
    -p 29418:29418 \
    -e WEBURL=http://your.site.domain:8080 \
    -e DATABASE_TYPE=postgresql \
    -e AUTH_TYPE=LDAP \
    -e LDAP_SERVER=ldap://ldap.server.address \
    -e LDAP_ACCOUNTBASE=<ldap-basedn> \
    -d openfrontier/gerrit

## Setup sendemail options.
#####Some basic attributes in [gerrit.config sendmail section](https://gerrit-review.googlesource.com/Documentation/config-gerrit.html#sendemail) are supported.

    #Start gerrit docker with sendemail supported.
    #All SMTP_* attributes are optional.
    #Sendemail function will be disabled if SMTP_SERVER is not specified.
    docker run \
    --name gerrit \
    -p 8080:8080 \
    -p 29418:29418 \
    -e WEBURL=http://your.site.domain:8080 \
    -e SMTP_SERVER=smtp.server.address \
    -e SMTP_SERVER_PORT=25 \
    -e SMTP_ENCRYPTION=tls \
    -e SMTP_USER=<smtp user> \
    -e SMTP_PASS=<smtp password> \
    -e SMTP_CONNECT_TIMEOUT=10sec \
    -e SMTP_FROM=USER \
