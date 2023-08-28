ARG UBUNTU_RELEASE=22.04
ARG CUDA_VERSION=11.7.1
FROM nvcr.io/nvidia/cuda:${CUDA_VERSION}-runtime-ubuntu${UBUNTU_RELEASE}

ENV DATA_DIR /root/post
ENV NUM_UNITS 16
ENV PROVIDER 0
ENV COMMITMENT_ATX_ID 435fa442517e9c75087de1b06d2a9d12c345505f3cac93ac52b816171ce48308

WORKDIR /root

RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt reinstall -y ca-certificates && \
        update-ca-certificates && \
    apt-get install -y --no-install-recommends \
	wget \
	unzip \
	clinfo \
	ocl-icd-opencl-dev \
	ocl-icd-libopencl1 \
	pocl-opencl-icd \
	opencl-headers \
	python3-pip \
	rclone \
	;

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

ARG POSTCLI_VER=v0.9.2

RUN wget https://github.com/spacemeshos/post/releases/download/${POSTCLI_VER}/postcli-Linux.zip -O postcli.zip && unzip postcli.zip && chmod +x postcli


COPY upload/ ./upload/
RUN pip install -r upload/requirements.txt

COPY entrypoint.sh .

CMD [ "sleep", "inf" ]
ENTRYPOINT ["./entrypoint.sh"]


