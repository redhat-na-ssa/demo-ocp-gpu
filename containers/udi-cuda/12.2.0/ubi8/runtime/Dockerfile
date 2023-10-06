FROM ${IMAGE_NAME}:12.2.0-base-ubi8 as base

ENV NV_CUDA_LIB_VERSION 12.2.0-1

FROM base as base-amd64

ENV NV_NVTX_VERSION 12.2.53-1
ENV NV_LIBNPP_VERSION 12.1.1.14-1
ENV NV_LIBNPP_PACKAGE libnpp-12-2-${NV_LIBNPP_VERSION}
ENV NV_LIBCUBLAS_VERSION 12.2.1.16-1

FROM base as base-arm64
ENV NV_NVTX_VERSION 12.2.53-1
ENV NV_LIBNPP_VERSION 12.1.1.14-1
ENV NV_LIBNPP_PACKAGE libnpp-12-2-${NV_LIBNPP_VERSION}
ENV NV_LIBCUBLAS_VERSION 12.2.1.16-1

FROM base as base-ppc64le
ENV NV_NVTX_VERSION 12.2.53-1
ENV NV_LIBNPP_VERSION 12.1.1.14-1
ENV NV_LIBNPP_PACKAGE libnpp-12-2-${NV_LIBNPP_VERSION}
ENV NV_LIBCUBLAS_VERSION 12.2.1.16-1

FROM base-${TARGETARCH}

ARG TARGETARCH

LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN yum install -y \
    cuda-libraries-12-2-${NV_CUDA_LIB_VERSION} \
    cuda-nvtx-12-2-${NV_NVTX_VERSION} \
    ${NV_LIBNPP_PACKAGE} \
    libcublas-12-2-${NV_LIBCUBLAS_VERSION} \
    && yum clean all \
    && rm -rf /var/cache/yum/*

# Add entrypoint items
COPY entrypoint.d/ /opt/nvidia/entrypoint.d/
COPY nvidia_entrypoint.sh /opt/nvidia/
ENV NVIDIA_PRODUCT_NAME="CUDA"
ENTRYPOINT ["/opt/nvidia/nvidia_entrypoint.sh"]

USER 1001