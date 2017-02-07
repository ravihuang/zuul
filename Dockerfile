FROM openfrontier/gerrit

MAINTAINER ravih <ravi.huang@gmail.com>
RUN git config --global core.quotepath false && \
    git config --global i18n.logoutputencoding utf8 && \
    git config --global i18n.commitencoding utf8
