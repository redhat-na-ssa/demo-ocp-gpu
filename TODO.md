## TODO

- [x] Create Nvidia GPU time-slicing config
- [x] Create Nvidia GPU MIG config
- [x] Setup OpenShift console plugins for Nvidia
- [ ] Show use of taints and tolerations
- [ ] Document offline install of Nvidia GPU Operator
- [ ] Make bash functions kustomization

## WIP
```
# aws gpu - MIG - NOT WORKING in RHDP
# requires zone - us-east-2b for p4d.24xlarge

ocp_aws_create_gpu_machineset p4d.24xlarge
setup_mig_config_nvidia single all-1g.5gb
```