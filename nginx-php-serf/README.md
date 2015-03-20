ementux/nginx-php-serf
======================

Base docker image to run NGINX with [Serf](https://serfdom.io/) and PHP modules necessary for WordPress.

Start container:

`$ docker run -d --name=nginx -p 80 ementux/nginx-php-serf`

Start container using host directories mounted as volumes:

`$ docker run -d --name=nginx-with-host-dirs -p 80 -v /host/dir/logs:/srv/www/logs -v /host/dir/app:/srv/www/public_html ementux/nginx-php-serf`

Start container using volumes from datastore container:

`$ docker run -d --name=nginx-with-datastore -p 80 --volumes-from=datastore ementux/nginx-php-serf`

Start container linked with MySQL/MariaDB container:

`$ docker run -d --name=nginx-with-mysql -p 80 --link mysql:mysql ementux/nginx-php-serf`
