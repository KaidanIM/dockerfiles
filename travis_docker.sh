#!/usr/bin/env bash

build() {
	if [ -f $IMAGE/Dockerfile ]; then
		cd $IMAGE
		sudo docker build -t "kaidan/${IMAGE}:latest" .
		cd ..
	fi
}

push() {
	echo "$DOCKER_PASSWORD" | sudo docker login -u "$DOCKER_USERNAME" --password-stdin

	if [ -f $IMAGE/Dockerfile ]; then
		sudo docker push "kaidan/${IMAGE}:latest"
	fi
}

$1
