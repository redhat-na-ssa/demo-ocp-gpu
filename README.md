# Demo GPUs on OpenShift

Show some magic around GPUs on OpenShift including

- DevSpaces
- GPU autoscaling in AWS

## Prerequisites

- OpenShift 4.12 deployed in AWS

## Quickstart

```
scripts/bootstrap.sh

# deploy gpu test pod
oc apply -f https://raw.githubusercontent.com/NVIDIA/gpu-operator/master/tests/gpu-pod.yaml
```

## Links

- https://cloud.redhat.com/blog/autoscaling-nvidia-gpus-on-red-hat-openshift
- https://github.com/bkoz/devspaces
