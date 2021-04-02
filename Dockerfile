
FROM ubuntu:20.04

ENV PYTHONPATH="/root/openpilot:${PYTHONPATH}"
ENV PATH="/root/.pyenv/bin:${PATH}"
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y git python3 curl git-lfs build-essential zlib1g-dev bzip2 zlib1g libssl-dev libffi-dev liblzma-dev

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    build-essential \
    bzip2 \
    ca-certificates \
    capnproto \
    clang \
    cmake \
    cppcheck \
    curl \
    ffmpeg \
    gcc-arm-none-eabi \
    git \
    iputils-ping \
    libarchive-dev \
    libbz2-dev \
    libcapnp-dev \
    libcurl4-openssl-dev \
    libeigen3-dev \
    libffi-dev \
    libgles2-mesa-dev \
    libglew-dev \
    libglib2.0-0 \
    liblzma-dev \
    libomp-dev \
    libopencv-dev \
    libsqlite3-dev \
    libssl-dev \
    libsystemd-dev \
    libusb-1.0-0-dev \
    libzmq3-dev \
    locales \
    ocl-icd-libopencl1 \
    ocl-icd-opencl-dev \
    opencl-headers \
    python-dev \
    qml-module-qtquick2 \
    qt5-default \
    qtmultimedia5-dev \
    qtwebengine5-dev \
    sudo \
    valgrind \
    wget \
  && rm -rf /var/lib/apt/lists/*

# install opencv deps
# TODO: Move these to first apt-get install batch
ENV OPENCV_VERSION='4.2.0' 

RUN sudo apt-get -y update && \
    sudo apt-get install -y build-essential cmake && \
    sudo apt-get install -y qt5-default libvtk6-dev && \
    sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev \
                            libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm \
                            libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev && \
    sudo apt-get install -y libtbb-dev libeigen3-dev 


RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:${PATH}"

# need to use a pip.conf because pip fails to see $PATH in container properly?
COPY pip.conf="/root/pip.conf"
ENV PIP_CONFIG_FILE="/root/pip.conf"

COPY --chown=root:root openpilot /root/openpilot
RUN cd /root/openpilot && git submodule update --init --recursive

RUN cd /root/openpilot && ./tools/ubuntu_setup.sh

RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz && \
    tar -xvf ${OPENCV_VERSION}.tar.gz && rm ${OPENCV_VERSION}.tar.gz && \
    mv opencv-${OPENCV_VERSION} OpenCV && \
    cd OpenCV && mkdir build && cd build && \
    cmake -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON \
          -DWITH_XINE=ON -DENABLE_PRECOMPILED_HEADERS=OFF .. && \
    make -j8 && \
    sudo make install && \
    sudo ldconfig

RUN pip install scons 
RUN cd /root/openpilot && USE_WEBCAM=1 scons -j$(nproc)