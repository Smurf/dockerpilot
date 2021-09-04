xhost +local:docker
docker run -it --rm --gpus all \
	-e DISPLAY=$DISPLAY \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
	-e QT_DEBUG_PLUGINS=1 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	192.168.0.110:5000/openpilot:latest \
	apt-get install mesa-utils -y && glxgears
