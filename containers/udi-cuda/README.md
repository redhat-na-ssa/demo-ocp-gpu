# Info

Using upstream container build from Nvidia

## Quickstart

```
cd containers/udi-cuda/12.2.0/ubi8/

cd base
podman build . -t udi-cuda:12.2.0-base-ubi8

cd ../runtime
podman build . -t udi-cuda:12.2.0-runtime-ubi8 --build-arg IMAGE_NAME=udi-cuda

cd ../devel
podman build . -t udi-cuda:12.2.0-devel-ubi8 --build-arg IMAGE_NAME=udi-cuda
```

## Links

- [Nvidia Container Source - cuda/dist/12.2.0/ubi8/base](https://gitlab.com/nvidia/container-images/cuda.git)
- [Dev Spaces - Developer Images](https://github.com/devfile/developer-images)

## Notes

```
diff --git a/containers/udi-cuda/12.2.0/ubi8/base/Dockerfile b/containers/udi-cuda/12.2.0/ubi8/base/Dockerfile
index 733adec..532b9c3 100644
--- a/containers/udi-cuda/12.2.0/ubi8/base/Dockerfile
+++ b/containers/udi-cuda/12.2.0/ubi8/base/Dockerfile
@@ -1,9 +1,4 @@
-# FROM registry.access.redhat.com/ubi8/ubi:latest as base
-ARG IMAGE_NAME=quay.io/devfile/base-developer-image:ubi8-latest
-ARG TARGETARCH=amd64
-FROM ${IMAGE_NAME} as base
-
-USER 0
+FROM registry.access.redhat.com/ubi8/ubi:latest as base
 
 FROM base as base-amd64
 
@@ -59,6 +54,4 @@ COPY NGC-DL-CONTAINER-LICENSE /
 
 # nvidia-container-runtime
 ENV NVIDIA_VISIBLE_DEVICES all
-ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
-
-USER 1001
\ No newline at end of file
+ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
\ No newline at end of file
diff --git a/containers/udi-cuda/12.2.0/ubi8/devel/Dockerfile b/containers/udi-cuda/12.2.0/ubi8/devel/Dockerfile
index 4f33e7c..055959b 100644
--- a/containers/udi-cuda/12.2.0/ubi8/devel/Dockerfile
+++ b/containers/udi-cuda/12.2.0/ubi8/devel/Dockerfile
@@ -3,8 +3,6 @@ FROM ${IMAGE_NAME}:12.2.0-runtime-ubi8 as base
 
 FROM base as base-amd64
 
-USER 0
-
 ENV NV_CUDA_LIB_VERSION 12.2.0-1
 ENV NV_NVPROF_VERSION 12.2.60-1
 ENV NV_NVPROF_DEV_PACKAGE cuda-nvprof-12-2-${NV_NVPROF_VERSION}
@@ -61,6 +59,4 @@ RUN yum install -y \
     && yum clean all \
     && rm -rf /var/cache/yum/*
 
-ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs
-
-USER 1001
\ No newline at end of file
+ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs
\ No newline at end of file
diff --git a/containers/udi-cuda/12.2.0/ubi8/runtime/Dockerfile b/containers/udi-cuda/12.2.0/ubi8/runtime/Dockerfile
index d0e0ff5..194fb8c 100644
--- a/containers/udi-cuda/12.2.0/ubi8/runtime/Dockerfile
+++ b/containers/udi-cuda/12.2.0/ubi8/runtime/Dockerfile
@@ -1,8 +1,6 @@
 ARG IMAGE_NAME
 FROM ${IMAGE_NAME}:12.2.0-base-ubi8 as base
 
-USER 0
-
 ENV NV_CUDA_LIB_VERSION 12.2.0-1
 
 FROM base as base-amd64
@@ -41,7 +39,4 @@ RUN yum install -y \
 COPY entrypoint.d/ /opt/nvidia/entrypoint.d/
 COPY nvidia_entrypoint.sh /opt/nvidia/
 ENV NVIDIA_PRODUCT_NAME="CUDA"
-
-USER 1001
-
 ENTRYPOINT ["/opt/nvidia/nvidia_entrypoint.sh"]
\ No newline at end of file
```
