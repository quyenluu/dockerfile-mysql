FROM ubuntu:18.04

MAINTAINER quyenluu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y upgrade

ENV MYSQL_USER=mysql \
    MYSQL_VERSION=5.7.29 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN apt-get install -y mysql-server=${MYSQL_VERSION}* \	
	&& rm -rf ${MYSQL_DATA_DIR} \
 	&& rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/mysql

COPY entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/entrypoint.sh /entrypoint.sh # backwards compat
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]