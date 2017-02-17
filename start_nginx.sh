#!/usr/bin/bash

nginx -g "daemon on;"
/etc/init.d/fcgi-run start
