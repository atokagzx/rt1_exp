FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Timezone Configuration
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y    apt-utils \
                                    lsb-release \
                                    mesa-utils \
                                    gnupg2 \
                                    net-tools \
                                    iputils-ping \
                                    build-essential \
                                    wget \
                                    unzip \
                                    curl \
                                    git \
                                    mc \
                                    vim \
                                    nano \
                                    ffmpeg \
                                    x11-apps

## GUI tunnel from docker
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        libxau6 libxau6:i386 \
        libxdmcp6 libxdmcp6:i386 \
        libxcb1 libxcb1:i386 \
        libxext6 libxext6:i386 \
        libx11-6 libx11-6:i386 && \
    rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=12.0"


RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

RUN apt-get update && apt-get install -y --no-install-recommends \
        libglvnd0 libglvnd0:i386 \
        libgl1 libgl1:i386 \
        libglx0 libglx0:i386 \
        libegl1 libegl1:i386 \
        libgles2 libgles2:i386 && \
    rm -rf /var/lib/apt/lists/*
# Required for non-glvnd setups.
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64


RUN apt update &&  apt install -y make \
                                libssl-dev \
                                zlib1g-dev \
                                libbz2-dev \
                                libreadline-dev \
                                libsqlite3-dev \
                                llvm \
                                libncurses5-dev \
                                libncursesw5-dev \
                                xz-utils \
                                tk-dev \
                                libffi-dev \
                                liblzma-dev \
                                libgdbm-dev \
                                libnss3-dev \
                                libedit-dev \
                                libc6-dev \
                                cmake \
                                unzip \
                                autoconf \
                                autogen \
                                automake \
                                libtool \
                                mlocate

# RUN apt update && apt install -y python3-pip python3-dev

WORKDIR /
# updating cmake to 3.13
RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3.tar.gz && tar zxvf cmake-3.26.3.tar.gz
WORKDIR /cmake-3.26.3
RUN ./bootstrap && make -j4 && make install

WORKDIR /
RUN curl -O https://www.python.org/ftp/python/3.7.16/Python-3.7.16.tgz && tar -xzf Python-3.7.16.tgz
WORKDIR /Python-3.7.16
RUN ./configure --enable-optimizations  -with-lto
RUN make -j$(nproc)
RUN make altinstall

RUN apt update && apt install -y python3-pip
RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade pip

# RUN apt update && apt install -y python3.7-pip
WORKDIR /
RUN wget "https://github.com/protocolbuffers/protobuf/releases/download/v22.2/protoc-22.2-linux-x86_64.zip"
RUN unzip protoc-22.2-linux-x86_64.zip -d /protoc 
RUN python3.7 -m pip install absl-py>=0.5.0 \
        numpy>=1.13.3
RUN python3.7 -m pip install tensorflow-gpu==1.15.5
RUN python3.7 -m pip install "tensorflow-serving-api"==1.15.0 "gin-config" Pillow==5.3.0 six==1.12.0 "tensorflow-probability" "tf-agents"==0.3.0 "tf-slim">=1.0

RUN python3.7 -m pip install pybullet \
                gym
WORKDIR /
# RUN curl https://raw.githubusercontent.com/protocolbuffers/protobuf/main/python/google/protobuf/internal/builder.py > /usr/local/lib/python3.7/dist-packages/google/protobuf/internal/builder.py

RUN  apt update && \
    apt install apt-transport-https curl gnupg -y && \
    curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg && \
    mv bazel-archive-keyring.gpg /usr/share/keyrings && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" |  tee /etc/apt/sources.list.d/bazel.list && \
    apt update && \
    apt install -y bazel
RUN python3.7 -m pip install protobuf==3.20 "tensorflow-probability"==0.7.0
# RUN curl https://raw.githubusercontent.com/protocolbuffers/protobuf/main/python/google/protobuf/internal/builder.py > /usr/local/lib/python3.7/dist-packages/google/protobuf/internal/builder.py
# WORKDIR /
# RUN wget "https://github.com/protocolbuffers/protobuf/releases/download/v22.2/protoc-22.2-linux-x86_64.zip"
# RUN unzip protoc-22.2-linux-x86_64.zip -d /protoc
# RUN pip3 install absl-py>=0.5.0 \
#         numpy>=1.13.3 \
#         tensorflow>=1.14.0
# RUN pip3 install "tensorflow-serving-api"==1.14.0 "gin-config" pybullet==2.5.0 Pillow==5.3.0 gym>=0.10.9 six==1.12.0 "tensorflow-probability"==0.7.0 "tf-agents"==0.3.0

# # RUN pip3 --version
# RUN pip3 install "tensorflow-probability" "tf-slim">=1.0

# # RUN pip3 install wheel packaging requests opt_einsum
# # RUN pip3 install keras_preprocessing --no-deps

# # RUN apt update && apt install -y build-essential curl git cmake unzip autoconf autogen automake libtool mlocate zlib1g-dev wget
# RUN apt update && apt install -y python3-numpy python3-wheel
# WORKDIR /
# # RUN git clone -b r1.15 https://github.com/tensorflow/tensorflow.git
# RUN wget https://github.com/bazelbuild/bazel/releases/download/0.24.1/bazel-0.26.1-installer-linux-x86_64.sh && chmod +x bazel-0.26.1-installer-linux-x86_64.sh
# RUN ./bazel-0.26.1-installer-linux-x86_64.sh --user
# ENV PATH="$PATH:/root/bin"
# # RUN ls /root/bin
# WORKDIR /tensorflow
# RUN ./configure
# # RUN find -name cuda.h
# # RUN sed -i '1icuda_path = "C:/Program\ Files/NVIDIA\ GPU\ Computing\ Toolkit/CUDA/v10.1"\ncudnn_path = "C:/tools/cuda"' third_party/gpus/find_cuda_config.py
# # RUN cat third_party/gpus/find_cuda_config.py
# RUN apt update && apt install -y nvidia-cuda-toolkit
# # RUN bazel build --config=cuda //tensorflow/tools/pip_package:build_pip_package
# # RUN apt update && apt install -y python3-distutils
# RUN bazel build --jobs 12 --config=opt --config=monolithic --config=v1 //tensorflow/tools/pip_package:build_pip_package

# # RUN /root/bin/bazel build --config=cuda [--config=option] //tensorflow/tools/pip_package:build_pip_package

# # RUN pip3 install tensorflow==1.13.0

# ENTRYPOINT [ "nvidia-smi" ]
RUN python3.7 -m pip install scipy
RUN python3.7 -m pip install keras==2.4 --no-dependencies
WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]