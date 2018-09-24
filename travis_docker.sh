#!/usr/bin/env bash

build() {
	for image in *; do
		if [ -f $image/Dockerfile ]; then
			cd $image
			docker build -t "kaidan/${image}:latest" .
			cd ..
		fi
	done
}

push() {
	echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

	for image in *; do
		if [ -f $image/Dockerfile ]; then
			docker docker push "kaidan/${image}:latest"
		fi
	done
}

$1
