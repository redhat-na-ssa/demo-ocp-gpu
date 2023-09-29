# Nvidia Multi Instance GPU (MIG) configuration on OpenShift

Red Hat Demo Platform Catalog (RHDP) option:

- `MLOps Demo: Data Science & Edge Practice`

*MIG demo is currently a WIP for RHDP*

### AWS Notes

AWS type `p4d.24xlarge` is currently only in availability zone `us-east-2b`.

If your cluster does not have a machine set in `us-east-2b` you
will probably not be able to request this GPU type.


## Nvidia MIG profiles

Setup MIG profile

```
. scripts/bootstrap.sh

# setup MIG single
# ex: nvidia.com/gpu: 1
nvidia_setup_mig_config single all-1g.5gb
nvidia_setup_mig_config single all-2g.10gb

# setup MIG mixed
# ex: nvidia.com/mig-2g.10gb: 1
nvidia_setup_mig_config mixed all-balanced
```

Manually Pick MIG profile

```
# mode = single / mixed
MIG_CONFIG=all-1g.5gb
MIG_CONFIG=all-2g.10gb

# mode = mixed 
MIG_CONFIG=all-balanced
```

Manually apply MIG partitioning profile(s) - Mixed

```
# add profile label
oc label node --overwrite \
  -l "node-role.kubernetes.io/gpu" \
  "nvidia.com/mig.config=${MIG_CONFIG}"

# remove profile label
oc label node --overwrite \
  -l "node-role.kubernetes.io/gpu" \
  "nvidia.com/mig.config-"
```
