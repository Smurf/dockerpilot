# dockerpilot

Build OpenPilot in a docker container with more ease, at the expense of time, and without depending on commaai's base image.

# Caveats

* The container is currently configured to build only the master branch of [my own branch](https://github.com/Smurf/openpilot).

* You must be in the docker group.

## Requirements

* CUDA Capable GPU
* nVidia Proprietary Drivers
* nvidia-container-runtime
    - https://github.com/NVIDIA/nvidia-container-runtime

### Dockerfiles

The build consists of 4 dockerfiles that are built in this order.

* Dockerfile.base
    - Contains Nvidia env vars.
	- nvidia/cudagl:11.2.2-devel-ubuntu20.04
		- OpenGL context for QT to render to so glvnd is required.
	- nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04
		- CUDNN is required and OpenCV is compiled with it.
* Dockerfile.stage2
    - Contains rest of env vars for the cotainer.
    - Clones OP
    - Installs OpenCL
    - Runs `ubuntu_setup.sh`
    - Installs onnxruntime-gpu and scons
* Dockerfile.stage3
    - Builds opencv
* Dockerfile.build
    - Copies and applies patches
    - Builds openpilot
### Test

To see if you can run a cuda accelerated container run the following.
```
docker run -it --rm --gpus all nvidia/cuda nvidia-smi -L
```

Further testing scripts are provided in the `run-scripts` directory.

##  Use
```
$ git clone https://github.com/Smurf/dockerpilot.git
$ cd dockerpilot
$ git clone https://github.com/commaai/openpilot.git
$ ./build-all.sh #This may take 3+ hours depending on CPU
$ ./run.sh
```

# Screenshots

![works on my machine haha](./works-on-my-machine.png)

![ui pic](./qt-ui.png)
