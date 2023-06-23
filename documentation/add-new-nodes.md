
## Node operations
### New node creation
The process of creating a new node consists of the following steps:
- [Creating an EKS node group](#creating-an-eks-node-group)
- [Creating a secret](#creating_a_secret) in AWS (optional, more on that later) and importing it to Kubernetes
- (Optional) [Creating an ingress](#creating-an-ingress)


### Common terraform commands: 
Depending on the environment (dev or mainnet)

 - Initialize the module:\
   For dev environment
```shell
   terraform init -backend-config=../filecoin-glif-dev-apn1.hcl
```
   For mainnet environment
```shell
   terraform init -backend-config=../filecoin-glif-mainnet-apn1.hcl
```

- Select the appropriate workspace:\
  For dev environment
```shell
   terraform workspace select filecoin-glif-dev-apn1
````
  For mainnet environment
```shell
   terraform workspace select filecoin-glif-mainnet-apn1
````

 - Plan and apply the changes:\
   For dev environment
```shell
  terraform plan -var-file=tfvars/filecoin-glif-dev-apn1.tfvars
```
```shell
  terraform apply -var-file=tfvars/filecoin-glif-dev-apn1.tfvars
```
   For mainnet environment
```shell
  terraform plan -var-file=tfvars/filecoin-glif-mainnet-apn1.tfvars
```
```shell
  terraform apply -var-file=tfvars/filecoin-glif-mainnet-apn1.tfvars
```


## Creating an EKS node group
To create a new EKS node group, follow these steps:
1. Clone the [filecoin-iac](https://github.com/glifio/filecoin-iac) repository and open it in your text editor of choice.
2. Go to the aws module:
```shell
   cd aws
```
3. Initialize the module.
4. Select the appropriate workspace.
5. Depending on the environment (dev or mainnet), open either the `nodegroup_dev.tf` or the `nodegroup_mainnet.tf` file.
6. Add a new instance of the eks_nodegroup module. Refer to the [configuration options](../modules/eks_nodegroup/README.md).

#### Things of note here:
- Use meaningful node group names.
- To create a spot instance, set the `is_spot_instance` variable to `true` recommended for supporting nodes.
- To create an archival node:
    - set `use_existing_ebs` to true.
    - set `ebs_tenant` to the `Tenant tag` value of the EBS volumes.\
      During the instance initialization, the script will attach the volumes marked with the `tag` to the instance and create a logical volume on top of them.


Example:
```
module "eks_nodegroup" {
count                                   = local.is_prod_envs                
source                                  = "../modules/eks_nodegroup"        
ami_type                                = "AL2_ARM_64"                     
get_instance_type                       = "r6gd.4xlarge"                   
get_nodegroup_name                      = "${INSTANCE_NAME}"                         
get_global_configuration                = local.make_global_configuration   
get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
is_spot_instance                        = true                            
}
```
7. Plan and apply the changes.



## Creating a secret
This step is only required if you enable the `INFRA_SECRETVOLUME` variable for the lotus Docker container.\
That’s needed to persist the authentication token and the node ID in case the instance is recreated and lotus attempts to regenerate the secret.

**NB! The secret name in Kubernetes has to match the following convention**: `<helm_release_name>-lotus-secret`. In case of using the secrets_generator module, set the name variable to `<helm_release_name>-lotus`.

### Create a new AWS secret and import it to Kubernetes
To create a new secret, follow these steps:
1. Clone the [filecoin-iac](https://github.com/glifio/filecoin-iac) repository and open it in your text editor of choice.
2. Go to the k8s module:
```shell
   cd k8s
```
3. Initialize the module.
4. Select the appropriate workspace.
5. Open the `secrets.tf` file.
Add a new instance of the secrets_generator module. Refer to the [configuration options](../modules/secrets_generator/README.md).

Example:
```
module "spacenet_secret" {
  source = "../modules/secrets_generator"

  name = "spacenet-public"

  generator_config = local.generator_config
}
```
### Import an existing AWS secret to Kubernetes.
The steps to import an existing secret to Kubernetes are the same as for creating a new one (look at the section above)\
except that we use the `from_secret` variable of the secrets_generator module to designate which AWS secret to import the data from.

Example:
```
module "spacenet_slave_0_secret" {
source = "../modules/secrets_generator"

name        = "spacenet-public-slave-0"
from_secret = module.spacenet_secret.aws_secret_name

generator_config = local.generator_config
}
```
6. Plan and apply the changes.


## Creating an ingress
That step is only required if you’re creating a standalone node and not supporting one.\
Supporting node implies that the ingress already exists and leads to a service that matches the pod of the supporting lotus node.
### Using the Kong Gateway module
You can use the Kong Gateway module to create a set of ingresses for the new network.\
It supports only HTTP(S) connections, so to create a WSS ingress use the ovh_ingress module separately.

To create a new Kong Gateway instance, follow these steps:
1. Clone the [filecoin-iac](https://github.com/glifio/filecoin-iac) repository and open it in your text editor of choice.
2. Go to the `k8s` folder.
3. Initialize the module.
4. Select the appropriate terraform workspace.
5. Open the `api_gateway_kong.tf` file.
6. Add a new instance of the api_gw_kong module. Refer to the [configuration options](../modules/api_gw_kong/README.md).

Example:
```
module "api_gateway_kong_mainnet" {
count = local.is_prod_envs

source        = "../modules/api_gw_kong"
global_config = local.make_global_configuration

stage_name  = "mainnet"
domain_name = "api.node.glif.io"

ingress_class    = "external"
namespace        = "network"
upstream_service = "api-read-master-lotus"
}
```
6. Plan and apply the changes.

### Using the ovh_ingress module
The ovh_ingress module is a flexible way to create ingresses in both EKS and OVH environments.

To create a new ingress using this module, follow these steps:
1. Clone the [filecoin-iac](https://github.com/glifio/filecoin-iac) and open it in your text editor of choice.
2. Go to the `k8s` folder.
3. Initialize the module.
4. Select the appropriate workspace.
5. Depending on the selected environment, open either the `modules-ingress-dev.tf` of the `modules-ingress-mainnet.tf` file.
6. Add a new instance of the ovh_ingress module. Refer to the [configuration options](../modules/ovh_ingress/README.md).

Example:

```
module "ingress_example" {
  name   = "${ingress_example}"
  source = "../modules/ovh_ingress"

  namespace = "${namespace_example"}"

  http_host      = "${domain_name}"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "${service_name}"
  service_port = 80

  enable_path_transformer = false
  enable_access_control   = false
  enable_return_json      = false
}

```
7. Plan and apply the changes.


## Deploying the lotus helm chart
Refer to the filecoin-chart documentation.
