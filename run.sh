xhost +local:docker
docker run -it --rm --gpus all \
	-e DISPLAY=$DISPLAY \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
	-e QT_DEBUG_PLUGINS=1 \
    -e QT_X11_NO_MITSHM=1 \
    -e USE_WEBCAM=1 \
    --security-opt seccomp:unconfined \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
    --device=/dev/video4:/dev/video0 \
    --device=/dev/video0:/dev/video1 \
    --device=/dev/dri:/dev/dri \
	192.168.0.110:5000/openpilot:latest \
	/root/openpilot/selfdrive/manager/manager.py
