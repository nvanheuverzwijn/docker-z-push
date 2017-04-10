# Z-Push Docker

An attempt at dockerizing z-push. This container is not the official z-push container in any way but is a good start if you are looking to do it.

This container run z-push on `debian`, `apache2` and `php-fpm`.

## Install

There are two main way to use this container. 

  1. Extend this container using `FROM` keyword
  2. Mount every file you need on run-time by using the `-v` argument of `docker run`

## Installing your backend

Your backend needs to be in `/usr/share/z-push/backend/yourbackend`. Below are two examples of installing a backend :

```
FROM nvanheuverzwijn:z-push

COPY ./mybackend /usr/share/z-push/backend/mybackend
```

You can also mount every folder on runtime.

```
docker run -t nvanheuverzwijn/z-push -v /mybackend:/usr/share/z-push/backend/mybackend
```

## Configuration
Configuration must be set here `/etc/z-push/z-push.conf.php`. Like before, you can mount a configuration file on run-time with `-v` flag or roll your own container.

## Logs

Every log from apache and php5-fpm is going to PID1 stdout which is the stdout of docker.

## Examples

### Build and run

```
docker build . -t z-push
docker run --name z-push -p 80:80 --rm -t z-push
```

### Start a shell:

```
docker run --rm --name z-push  -p 80:80 -t z-push
docker exec -ti z-push /bin/bash
```

### Mounting configuration and backend on run-time:

Assuming that `~/mybackend` is the emplacement of your backend and that `~/z-push.conf` is the z-push configuration:

```
docker run --rm --name z-push -v ~/mybackend:/usr/share/z-push/backend/mybackend -v ~/z-push.conf:/etc/z-push/z-push.conf-t z-push
```
