ementux/datastore
=================

This image is used to keep data for scalable WP site. By default there are prepared following volumes:

- /var/lib/mysql
- /srv/www/logs
- /srv/www/public_html

Example usage
-------------

Create datastore container:

`$ docker run --name=datastore ementux/datastore`

Create datastore container with custom defined volumes:

`$docker run --name=datastore -v /some/host/dir:/var/lib/mysql ementux/datastore`

Connect prepared volumes to another container:

`$ docker run -d --name=mysql --volumes-from=datastore mysql`

Check if appropriate volume is mounted from data container:

```
$ docker inspect mysql

...

},
    "Volumes": {
        "/srv/www/logs": "/var/lib/docker/vfs/dir/d1741b0dc669d6efbe4e7a7621a52e384bb2dd9b35a6f400aa64844b3ffcacfc",
        "/srv/www/public_html": "/var/lib/docker/vfs/dir/ddd543ecc030bcdb4d9d4dad7a235656a90de82a0f6a9ae607fca618dc3df23d",
        "/var/lib/mysql": "/var/lib/docker/vfs/dir/e7c1f3b5c9b8bf2e0fdd5ba8034c1fb4bba8a259f028668bafb1025fb366ba8b"
    },
    "VolumesRW": {
        "/srv/www/logs": true,
        "/srv/www/public_html": true,
        "/var/lib/mysql": true
    }
```
