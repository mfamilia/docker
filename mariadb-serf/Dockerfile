# 
# ementux/mariadb
#
# MariaDB container for scalable web
#
# See https://github.com/ementux/docker
#
FROM ementux/base
MAINTAINER Michal Grna <michal.grna@ementux.org>

# install MariaDB
RUN yum -y update && yum -y install mariadb mariadb-server pwgen && yum clean all

# add configuration and wrapper for MariaDB
COPY my.cnf /etc/my.cnf
RUN chmod 644 /etc/my.cnf
COPY config-mariadb.sh /config-mariadb.sh
RUN chmod 755 /config-mariadb.sh
RUN mkdir -p /etc/service/mariadb/
COPY mariadb.run /etc/service/mariadb/run
RUN chmod 755 /etc/service/mariadb/run

# add volume for MariDB
VOLUME [ "/var/lib/mysql" ]

# expose MariaDB port
EXPOSE 3306

# start MariaDB 
ENTRYPOINT [ "/usr/sbin/runit_bootstrap" ]

