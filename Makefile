# see https://github.com/mvanholsteijn/docker-makefile/blob/master/Makefile

CONTAINER_CMD=podman
CONTAINER_BUILD_CONTEXT=.
CONTAINER_FILE_PATH=Dockerfile

RUSER=redhat-na-ssa
REGISTRY=ghcr.io
VERSION=latest

SHELL=/bin/bash


.PHONY: build


build: lint pre-build build-s2i-cuda-11 build-udi-cuda-11 build-udi-cuda-12 post-build


lint: venv lint-yaml lint-spellcheck


pre-build:


post-build:


main-build:


build-s2i-cuda-11:
	cd containers/s2i-cuda; \
	$(CONTAINER_CMD) build \
	-t $(REGISTRY)/$(RUSER)/udi-cuda:11.8.0-cudnn8-runtime-ubi8 \
	--build-arg IMAGE_NAME=docker.io/nvidia/cuda:11.8.0-cudnn8-runtime-ubi8 \
	$(CONTAINER_BUILD_CONTEXT) -f core/$(CONTAINER_FILE_PATH).rhel8

build-udi-cuda-11:
	cd containers/udi-cuda/ubi8; \
	$(CONTAINER_CMD) build \
	-t $(REGISTRY)/$(RUSER)/udi-cuda:11.8.0-cudnn8-runtime-ubi8 \
	--build-arg IMAGE_NAME=docker.io/nvidia/cuda:11.8.0-cudnn8-runtime-ubi8 \
	$(CONTAINER_BUILD_CONTEXT) -f $(CONTAINER_FILE_PATH)

	cd containers/udi-cuda/ubi8; \
	$(CONTAINER_CMD) build \
	-t $(REGISTRY)/$(RUSER)/udi-cuda:11.8.0-cudnn8-devel-ubi8 \
	--build-arg IMAGE_NAME=docker.io/nvidia/cuda:11.8.0-cudnn8-devel-ubi8 \
	$(CONTAINER_BUILD_CONTEXT) -f $(CONTAINER_FILE_PATH)

build-udi-cuda-12:
	cd containers/udi-cuda/ubi8; \
	$(CONTAINER_CMD) build \
	-t $(REGISTRY)/$(RUSER)/udi-cuda:12.3.2-cudnn9-runtime-ubi8 \
	--build-arg IMAGE_NAME=docker.io/nvidia/cuda:12.3.2-cudnn9-runtime-ubi8 \
	$(CONTAINER_BUILD_CONTEXT) -f $(CONTAINER_FILE_PATH)

	cd containers/udi-cuda/ubi8; \
	$(CONTAINER_CMD) build \
	-t $(REGISTRY)/$(RUSER)/udi-cuda:12.3.2-cudnn9-devel-ubi8 \
	--build-arg IMAGE_NAME=docker.io/nvidia/cuda:12.3.2-cudnn9-devel-ubi8 \
	$(CONTAINER_BUILD_CONTEXT) -f $(CONTAINER_FILE_PATH)


push:
	$(CONTAINER_CMD) push $(REGISTRY)/$(RUSER)/udi-cuda:$(VERSION)
	$(CONTAINER_CMD) push $(REGISTRY)/$(RUSER)/udi-cuda:$(VERSION)
	$(CONTAINER_CMD) push $(REGISTRY)/$(RUSER)/s2i-cuda:$(VERSION)

lint-yaml:
	 $(VENV)/yamllint -c .yamllint .

lint-spellcheck:
	$(VENV)/pyspelling -c .spellcheck.yaml

include Makefile.venv
Makefile.venv:
	curl \
		-o Makefile.fetched \
		-L "https://github.com/sio/Makefile.venv/raw/v2022.07.20/Makefile.venv"
	echo "147b164f0cbbbe4a2740dcca6c9adb6e9d8d15b895be3998697aa6a821a277d8 *Makefile.fetched" \
		| sha256sum --check - \
		&& mv Makefile.fetched Makefile.venv
