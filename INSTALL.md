# Development Setup

This document outlines setting up Fedora 36 for [OpenPilot](https://github.com/commaai/openpilot) to run inside a docker container.

#### Why Docker?

Containers provide 3 main benefits

1. Velocity
    - Easily onboard new contributors to OP on x86
    - Compile OP and dependencies on a separate, more powerful, macine
    - Saves on debug time due to the container being a known quantity
2. Reproducibility
    - All developers have the same base packages to use
    - Contributors can fork the image and others can easily test their changes
3. Automated Testing
    - Containers are great for automated testing

## 1 Install NVidia Drivers

Follow the RPMFusion HowTo

https://rpmfusion.org/Howto/NVIDIA

> **NOTE:** Be sure to install the CUDA driver as well

## 2 Install Nvidia Docker Toolkit

The Nvidida Docker Toolkit provides access to Nvidia GPUs on the host system.

> **NOTE:** This is restricted to Maxell and newer GPUs.

#### Remove Default Docker/Podman

Remove the default podman and docker packages.
```

sudo dnf remove docker \
docker-client \
docker-client-latest \
docker-common \
docker-latest \
docker-latest-logrotate \
docker-logrotate \
docker-selinux \
docker-engine-selinux \
docker-engine
```

> **NOTE:** It is normal for many, seemingly important, dependencies to get removed.

#### Install dependencies

Install dependencies for nvidia docker toolkit.

```
# Probably unneeded on fedora
sudo dnf install -y tar bzip2 make automake gcc gcc-c++ vim pciutils elfutils-libelf-devel libglvnd-devel iptables
```

Add the official docker repo to dnf.
```
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
```

Add the CentOS 8 `nvidia-container-cli` for debugging.
> https://github.com/NVIDIA/libnvidia-container 
```
sudo url -s -L https://nvidia.github.io/libnvidia-container/centos8/libnvidia-container.repo | sudo tee /etc/yum.repos.d/nvidia-container-toolkit
```

Install containerd and docker-ce, start services and add `$USER` to `docker` group.
```
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker --now
sudo usermod -aG docker $USER
```

### Install nvidia-docker2

Finally ready to install the toolkit.
```
sudo dnf install nvidia-docker2
sudo systemctl restart docker
sudo systemctl status docker # Make sure things are good
```

## 3 Testing Functionality

#### nvidia-smi

```
docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi
####REDACTED####

+-----------------------------------------------------------------------------+
| NVIDIA-SMI 510.60.02    Driver Version: 510.60.02    CUDA Version: 11.6     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:03:00.0 Off |                  N/A |
| N/A   31C    P8    N/A /  N/A |      3MiB /  2048MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      2048      G                                       2MiB |
+-----------------------------------------------------------------------------+

```

#### cuda-demo-suite

This is a bit tricky as the package versions in the Nvidia supplied containers are pinned but the deb can be downloaded and extracted from which the demos can be ran.
```
#Download deb
apt-get download cuda-demo-suite-11-6
ar x cuda-demo-suite-11-6
tar xvf data.tar.xz
cd usr/local/cuda-11.6/extras/demo_suite
```
