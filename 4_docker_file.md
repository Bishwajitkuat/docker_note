# Dockerfile disection

Fockerfile containes the info, how to build the image

```Dockerfile
FROM debian:jessie
```

- `FROM` : by this word we indicate the base image of our new image from `debian:jessie`.

```Dockerfile
ENV NGINX_VERSION 1.11.10-1~jessie
```

- we can pass any enverioment variables with `ENV` command

```Dockerfile
RUN echo "\
     hello\
     world"
```

- `RUN` : with `RUN` command we can execute any shell command belongs to the base image.

```Dockerfile
EXPOSE 80 443
```

- expose these ports on the docker virtual network
- we still need to use -p to open/forward these ports on host.

```Dockerfile
WORKDIR /usr/share/nginx/html
```

- by default the working dir of `nginx` image is the root
- change working directory to root of nginx webhost
- using WORKDIR is preferred to using 'RUN cd /some/path'

```Dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

- it's required
- run this command when the container is launched
- only one CMD is allowed, so, if there are multiple, only last one will win.
