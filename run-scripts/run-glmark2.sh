xhost +local:docker
docker run -it --rm --gpus 0 \
	-e DISPLAY=$DISPLAY \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
	-e QT_DEBUG_PLUGINS=1 \
    -e QT_X11_NO_MITSHM=1 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	192.168.0.110:5000/openpilot:base \
	apt-get install -y glmark2 && glmark2
