## TODO

- [x] Create Nvidia GPU time-slicing config
- [x] Create Nvidia GPU MIG config
- [x] Setup OpenShift console plugins for Nvidia
- [ ] Show use of taints and tolerations
- [ ] Document [offline install](https://github.com/jharmison-redhat/oc-mirror-e2e) of Nvidia GPU Operator
- [ ] Make bash functions kustomization

## Offline Installer Notes

This repo will aid in an offline install, but common issues will include:

- [ ] Making container images available
- [ ] Cloning this repo
- [ ] Other software dependencies (ex: pip, maven)
- [ ] Storage

## General Notes

The following config will allow autoscaling with Dev Spaces [HERE](components/operators/devspaces/instance/base/devworkspace-config.yaml)

- [CRD File](https://github.com/devfile/devworkspace-operator/blob/9450aa8894047f242cb0b40ce8e0e60df13ea27c/deploy/deployment/openshift/objects/devworkspaceoperatorconfigs.controller.devfile.io.CustomResourceDefinition.yaml#L2360)