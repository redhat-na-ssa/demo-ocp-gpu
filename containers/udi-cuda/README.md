# Info

Using upstream container build from Nvidia

## Quickstart

```
cd 12.2.0/ubi8/base
podman build . -t udi-cuda:12.2.0-base-ubi8

cd ../runtime
podman build . -t udi-cuda:12.2.0-runtime-ubi8

cd ../devel
podman build . -t udi-cuda:12.2.0-devel-ubi8
```

## Links

- [Container Source - cuda/dist/12.2.0/ubi8/base](https://gitlab.com/nvidia/container-images/cuda.git)
