#!/bin/bash

# MariaDB configuration script

# initialize MariaDB
echo "=> Installing MariaDB ..."
/usr/bin/mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe &

# waiting for MariaDB to start
RET=1

while [[ RET -ne 0 ]]
do
	echo "=> Waiting for confirmation of MariaDB service startup"
	sleep 5
	/usr/bin/mysql -uroot -e "status" > /dev/null 2>&1
	RET=$?
done

# define accounts & passwords
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-$(pwgen -s 12 1)}
MYSQL_DB=${MYSQL_DB:-"testdb"}
MYSQL_USER=${MYSQL_USER:-"admin"}
MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD:-$(pwgen -s 12 1)}

# set root password
echo "=> Changing root password ..."
/usr/bin/mysqladmin -u root password $MYSQL_ROOT_PASSWORD

# mysql_secure_installation :-)
echo "=> Securing MariaDB installation ... "
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.user WHERE User='';"
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "DROP DATABASE test;"
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# create DB
echo "=> Creating DB $MYSQL_DB ..."
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $MYSQL_DB;"

# create admin account
echo "=> Creating user $MYSQL_USER ..."
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;"
/usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# print info to stdout (docker logs <container ID>)
echo "=> Done"
echo ""
echo "========================================================================"
echo " You can now connect to this MariaDB Server using:"
echo ""
echo " mysql -u$MYSQL_USER -p$MYSQL_USER_PASSWORD -h<host> -P<port>"
echo ""
echo " or"
echo " mysql -uroot -p$MYSQL_ROOT_PASSWORD"
echo ""
echo " MariaDB user 'root' is allowed only from localhost"
echo "========================================================================"	

# shutdown MariaDB
/usr/bin/mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
