IMAGE_BASE=mylivingweb/
DOMAIN=dockerdjango
PROJECT=api
PORT=8888
#Where you django code is located
MY_PWD =$(shell pwd)
DATA_DIR=$(MY_PWD)/app
REGISTRY=your-repo-here
#NO NEED TO EDIT BELOW THIS POINT
#UNLESS YOU HAVE A CUSTOM DOCKER REPO
IMAGE=$(PROJECT)_$(DOMAIN)
TAG=latest
TAG2=$(shell date +%s)
CONTAIN_DATA=/$(DOMAIN)/config/$(PROJECT)
CONTAIN_LOGS=/var/log/nginx
LOGS_DIR=$(MY_PWD)/logs

build:
	docker build --build-arg DOMAIN=$(DOMAIN) --build-arg PORT=$(PORT) --build-arg PROJECT=$(PROJECT) -t $(IMAGE_BASE)$(IMAGE):$(TAG) -t $(REGISTRY)/$(IMAGE):$(TAG) -f $(MY_PWD)/Dockerfile $(MY_PWD)
run:
	docker run -it -p $(PORT):$(PORT)/tcp -v $(DATA_DIR):$(CONTAIN_DATA) -v $(LOGS_DIR):$(CONTAIN_LOGS) $(IMAGE_BASE)$(IMAGE)
bash:
	docker exec -i -t $(IMAGE_BASE)$(IMAGE) /bin/bash
push:
	docker push $(REGISTRY)/$(IMAGE):$(TAG)
create:
	docker create --name=$(PROJECT) -v $(DATA_DIR):$(CONTAIN_DATA) -v $(LOGS_DIR):$(CONTAIN_LOGS) -p $(PORT):$(PORT)/tcp $(IMAGE_BASE)$(IMAGE):$(TAG)
