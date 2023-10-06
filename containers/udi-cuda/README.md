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

- [Nvidia - CUDA Container Sources](https://gitlab.com/nvidia/container-images/cuda.git)
- [Dev Spaces - Developer Images](https://github.com/devfile/developer-images)

## Notes
