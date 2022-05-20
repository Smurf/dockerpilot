#!/bin/bash
xhost +local:docker
docker run -it --gpus all \
	-e DISPLAY=$DISPLAY \
	-e ROADCAM_ID=0 \
	-e DRIVERCAM_ID=1 \
	-e PASSIVE=0 \
	-e NOSENSOR=1 \
	-e USE_WEBCAM=1 \
  -e QT_X11_NO_MITSHM=1 \
  --security-opt seccomp:unconfined \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/video0:/dev/video0 \
  --device=/dev/video1:/dev/video1 \
	openpilot:latest \
  bash
  #/root/openpilot/selfdrive/debug/uiview.py
