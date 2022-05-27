xhost +local:docker
docker run -it --rm --gpus all \
  --privileged \
	-e DISPLAY=$DISPLAY \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--device=/dev/video0 \
	dockerpilot:base \
	apt-get install -y mesa-utils && glxinfo
