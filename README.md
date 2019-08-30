# DwollaCI Docker Build

_A Docker image for building Docker images_

This Docker image requires a few volume mounts. First, the Docker socket must be mounted so that the Docker CLI in the container can talk to the daemon on the host. Second, the context of the Docker image being built should be mounted at `/docker-context`. Finally, if you'd like to push the images being built, mount credentials to do so at `/root/.docker/config.json`.

At runtime, set one or more commands on the container being started.

1. The first command is the location of the `Dockerfile` relative to the `/docker-context` volume.
2. Any subsequent commands are interpreted as Docker image tags.

## Examples

1. Build this image and tag it as `dwolla/dwollaci-docker-build:new-build`:

	```shell
	docker run \
	  -it \
	  --rm \
	  -v /var/run/docker.sock:/var/run/docker.sock \
	  -v "$PWD":/docker-context:ro \
	  dwolla/dwollaci-docker-build:latest \
	  Dockerfile \
	  dwolla/dwollaci-docker-build:new-build
	```

	This example will not push the built image because no credentials were mounted.
	
2. Build this image and push it using multiple tags using the current user's Docker credentials. (Assumes `docker login` has already been run)

	```shell
	docker run \
	  -it \
	  --rm \
	  -v "$HOME/.docker/config.json":/root/.docker/config.json:ro \
	  -v /var/run/docker.sock:/var/run/docker.sock \
	  -v "$PWD":/docker-context:ro \
	  dwolla/dwollaci-docker-build:latest \
	  Dockerfile \
	  dwolla/dwollaci-docker-build:tag1 \
	  dwolla/dwollaci-docker-build:tag2
	```

## Why would you do this?

If you have access to the Docker socket and and run `docker run`, why not just use `docker build`? Normally, you should do just that. Dwolla uses this image to simplify some Jenkins jobs where we need to build Docker images in a specific context. 