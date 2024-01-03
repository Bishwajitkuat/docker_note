# creating jekyll-server which will served files from current director of the host.

cd into bindmount_assignment directory

```shell
docker run -d -p 8080:4000 --name jekyll_server  -v $(pwd):/site bretfisher/jekyll-serve
```

Note: the server initially takes some time before it can serve any pages.
