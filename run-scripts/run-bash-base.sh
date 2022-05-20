#! /bin/bash

# This script will provide a terminal to the base dockerpilot image

xhost +local:docker
docker run -it --rm --gpus all \
	-e DISPLAY=$DISPLAY \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
	-e QT_DEBUG_PLUGINS=1 \
        -e QT_X11_NO_MITSHM=1 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
    --gpus all \
	openpilot:base \
	bash
