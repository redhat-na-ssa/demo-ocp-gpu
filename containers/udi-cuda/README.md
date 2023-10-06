# Info

Using upstream container build from Nvidia

## Quickstart

```
# local build - runtime
podman build . \
  -t udi-cuda:11.8.0-cudnn8-runtime-ubi8 \
  --build-arg IMAGE_NAME=docker.io/nvidia/cuda:11.8.0-cudnn8-runtime-ubi8

# local build - devel
podman build . \
  -t udi-cuda:11.8.0-cudnn8-devel-ubi8 \
  --build-arg IMAGE_NAME=docker.io/nvidia/cuda:11.8.0-cudnn8-devel-ubi8

# local build - runtime
podman build . \
  -t udi-cuda:12.2.0-runtime-ubi8 \
  --build-arg IMAGE_NAME=docker.io/nvidia/cuda:12.2.0-runtime-ubi8

# local build - devel
podman build . \
  -t udi-cuda:12.2.0-devel-ubi8 \
  --build-arg IMAGE_NAME=docker.io/nvidia/cuda:12.2.0-devel-ubi8

```

## Links

- [Nvidia - CUDA Container Sources](https://gitlab.com/nvidia/container-images/cuda.git)
- [Dev Spaces - Developer Images](https://github.com/devfile/developer-images)

## Notes
