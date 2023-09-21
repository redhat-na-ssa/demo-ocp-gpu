# Demo GPUs on OpenShift

Get Nvidia GPUs setup on OpenShift and explore platform capabilities.

This repo is intended to help setup GPU prerequisites for other demos.

## Prerequisites

- Nvidia GPU Hardware
- OpenShift 4.11+ deployed in AWS (for autoscaling)

## Quickstart

```
# setup operators
scripts/bootstrap.sh

# setup autoscaling in aws
. scripts/bootstrap.sh
setup_cluster_autoscaling

# deploy gpu test pod
oc apply -f https://raw.githubusercontent.com/NVIDIA/gpu-operator/master/tests/gpu-pod.yaml
```

## Links

- [AWS GPU Instances](https://aws.amazon.com/ec2/instance-types/#Accelerated_Computing)
- https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/openshift/time-slicing-gpus-in-openshift.html
- https://cloud.redhat.com/blog/autoscaling-nvidia-gpus-on-red-hat-openshift
- https://github.com/bkoz/devspaces

## TODO

- [ ] Document offline install of Nvidia GPU Operator
