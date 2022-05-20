#! /bin/bash

# This script is used to ensure that OpenCL support is enabled in the container with
# the current host machine configuration

xhost +local:docker
docker run -it --rm --gpus all \
	-e DISPLAY=$DISPLAY \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--device=/dev/video0 \
	--device=/dev/video2 \
	openpilot:base \
	apt-get install -y clinfo && clinfo
