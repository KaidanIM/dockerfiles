#!/usr/bin/env bash

build() {
	if [ -f $IMAGE/Dockerfile ]; then
		cd $IMAGE
		docker build -t "kaidan/${IMAGE}:latest" .
		cd ..
	fi
}

push() {
	echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

	if [ -f $IMAGE/Dockerfile ]; then
		docker push "kaidan/${IMAGE}:latest"
	fi
}

$1
