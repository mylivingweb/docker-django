### Django in Docker

* centos 7 base image

* python 3.5

* simple to use Makefile

* uwsgi and nginx configured


#### Easy to use

clone this repo then clone or symlink your django app into a folder in this repos directory to `app`. Make your custom configuration changes in the `Makefile`

change these values to reflect your project

```
IMAGE_BASE=mylivingweb/
DOMAIN=dockerdjango
PROJECT=api
PORT=8888
REGISTRY=your-repo-here
```

Once your settings are setup like you want, just run `make build` to build, `make run` to run the image, or `make create` which will create a docker container with your project name

If you run a private repo you can run a `make push` to push your container to your registry 