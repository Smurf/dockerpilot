# dockerpilot

Build OpenPilot in a docker container with more ease, at the expense of time, and without depending on commaai's base image.

# Caveats

* The container is currently configured to build only the master branch of [my own branch](https://github.com/Smurf/openpilot).

* You must be in the docker group.

## Requirements

* CUDA Capable GPU
* nVidia Proprietary Drivers
* nvidia-container-runtime
 - https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

### Dockerfiles

The build consists of 4 dockerfiles that are built in this order.

* Dockerfile.base
    - Contains Nvidia env vars.
	- nvidia/cudagl:11.2.2-devel-ubuntu20.04
		- OpenGL context for QT to render to so glvnd is required.
	- nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04
		- CUDNN is required
* Dockerfile.stage2
    - Sets up env vars for OpenCV build
    - Builds OpenCV
* Dockerfile.stage3
    - Clones OP git repo and populates submodules
    - Setup python env vars for pyenv
    - Run the ubuntu setup script
    - Ensure `$PATH` is set correctly
* Dockerfile.build
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
$ ./run-shell.sh
```
### Debugging

The `run-scripts` directory provides some helpful scripts to test things like OpenCL and OpenGL on the base container.

# Screenshots

![works on my machine haha](./works-on-my-machine.png)

![ui pic](./qt-ui.png)

# TODO

- [] Change name of containers to Dockerpilot instead of Openpilot
- [] Create scripts for testing webcams in the `latest` tagged container with `qv4l2`
