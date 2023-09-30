## TODO

- [x] Create Nvidia GPU time-slicing config
- [x] Create Nvidia GPU MIG config
- [x] Setup OpenShift console plugins for Nvidia
- [ ] Show use of taints and tolerations
- [ ] Document offline install of Nvidia GPU Operator
- [ ] Make bash functions kustomization

## Notes

The following config will allow autoscaling with Dev Spaces [HERE](components/operators/devspaces/instance/base/devworkspace-config.yaml)

- [CRD File](https://github.com/devfile/devworkspace-operator/blob/9450aa8894047f242cb0b40ce8e0e60df13ea27c/deploy/deployment/openshift/objects/devworkspaceoperatorconfigs.controller.devfile.io.CustomResourceDefinition.yaml#L2360)