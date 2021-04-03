# dockerpilot

This is just a bullshit attempt to get openpilot to build in a ubuntu 20.04 container.

# Caveats

* The container is currently configured to build only the master branch of the official openpilot repo.

* The container **does not** pass webcams through as-is. **Modify `run.sh` to pass through USB devices such as panda and webcams!**

## Requirements

* CUDA Capable GPU
* nVidia Proprietary Drivers
* nvidia-container-runtime
    - https://github.com/NVIDIA/nvidia-container-runtime

### Test

To see if you can run a cuda accelerated container run the following.
```
docker run -it --rm --gpus all fedora nvidia-smi -L
```

If the container can access the GPU output such as the following will be shown:
```
GPU 0: GeForce 840M (UUID: GPU-89ec8158-10c8-fb8d-eafa-19d9f1e9b1a0)
```

##  Use
```
$ git clone https://github.com/Smurf/dockerpilot.git
$ cd dockerpilot
$ git clone https://github.com/commaai/openpilot.git
$ docker build . -t openpilot
$ ./run.sh
```

![works on my machine haha](./works-on-my-machine.png)
