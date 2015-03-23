ementux/mariadb-serf
====================

Base docker image to run MariaDB database and [Serf](https://serfdom.io/) agent.

Start container:

`$ docker run -d --name=mariadb ementux/mariadb-serf`

Start container using host directories mounted as volumes:

`$ docker run -d --name=mariadb-host-dir -v /host/dir/db:/var/lib/mysql ementux/mariadb-serf`

Start container using volumes from datastore container:

`$ docker run -d --name=mariadb-with-datastore --volumes-from=datastore ementux/mariadb-serf`

Start container using volumes from datastore container and join Serf cluster (for scalable website):

`$ docker run -d --name=mariadb-data-and-serf --volumes-from=datastore --link=serf:serf ementux/mariadb-serf`

If container is started for the first time and there is no database initialized, MariaDB initialisation and configuration is invoked. You can check configuration output via `docker logs`:

```
$ docker run -d --name=mariadb ementux/mariadb-serf

$ docker logs mariadb

...
=> Done."

========================================================================
 You can now connect to this MariaDB Server using:

 mysql -uadmin -paeNariequ0ai -h<host> -P<port>

 or

 mysql -uroot -pchaibeyi1IYu

 MariaDB user 'root' is allowed only from localhost
========================================================================
```

Database configuration can be modified with following variables:

- MYSQL_ROOT_PASSWORD
- MYSQL_DB (default: testdb)
- MYSQL_USER (default: admin)
- MYSQL_USER_PASSWORD
