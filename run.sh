xhost +local:docker
docker run -it --rm --gpus all \
	-e DISPLAY=$DISPLAY \
    -e ROADCAM_ID=0 \
    -e DRIVERCAM_ID=1 \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
	-e QT_DEBUG_PLUGINS=1 \
    -e QT_X11_NO_MITSHM=1 \
    -e USE_WEBCAM=1 \
    -e __NV_PRIME_RENDER_OFFLOAD=1 \
    -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
    --security-opt seccomp:unconfined \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
    --device=/dev/video2:/dev/video0 \
    --device=/dev/video4:/dev/video1 \
    --device=/dev/dri:/dev/dri \
	192.168.0.110:5000/openpilot:latest \
    bash
	#/root/openpilot/selfdrive/manager/manager.py
