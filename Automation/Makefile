DOCKER_TAG=arch:test-local

build:
	@docker build . -t ${DOCKER_TAG}

dev: build
	@docker run -v ./src:/home/user -it ${DOCKER_TAG} bash
