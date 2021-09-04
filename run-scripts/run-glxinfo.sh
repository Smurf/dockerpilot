xhost +local:docker
#	--device=/dev/video2 \
docker run -it --rm --gpus all \
    --privileged \
	-e DISPLAY=$DISPLAY \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--device=/dev/video0 \
	192.168.0.110:5000/openpilot \
	apt-get install -y mesa-utils && glxinfo
