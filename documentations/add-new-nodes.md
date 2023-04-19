- [General information](#general-information)
- [Create nodegroup](#create-nodegroup)
  - [Create secret to AWS](#create-secret-to-aws)
  - [Create secret to Kubernetes](#create-secret-to-kubernetes)
- [Deploy Lotus with helm chart](#deploy-lotus-with-helm-chart)
- [Scenario to deploy if the secret exists](#scenario-if-the-secret-exists)
- [Scenario to deploy with the new secret](#scenario-with-the-new-secret)
  - [Create custom JWT token](#sreate-custom-jwt-token)
- [Delete lotus nodes](#delete-lotus-nodes)

## General information

Directories for creating new nodes:
[terraform](https://github.com/glifio/filecoin-iac) configuration for nodes in AWS/EKS.
[helm-chart](https://github.com/glifio/filecoin-chart) statefulset for pods EKS.

We use 2 clusters - prod\dev. Instances types: spot, on-demand. Domain management - AWS Route53.


## Create nodegroup 

1. Go to the repo [terraform](https://github.com/glifio/filecoin-iac)
2. cd **aws**/
3. Create initial check
```
   terraform init -backend-config=../filecoin-glif-dev-apn1.hcl
     
   terraform workspace list

   terraform workspace select ${workspace}
```

4. Select the file **nodegroup_dev.tf / nodegroup_mainnet.tf**

```
module "eks_nodegroup_spot_group5" {
count                                   = local.is_dev_envs                 //   environment where will be create your node (dev / main net)
source                                  = "../modules/eks_nodegroup"        //   directory should be used to apply the code
ami_type                                = "AL2_ARM_64"                      //   architecture type should be used by  the node
get_instance_type                       = "r6gd.4xlarge"                    //   instance type should be used by  the node (CPU,RAM,disk)
get_nodegroup_name                      = "group5"                          //   don't need to type ondemand/spot in the name, it will be added automatically.
get_global_configuration                = local.make_global_configuration   //   global config should be used by the  node
get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
is_spot_instance                        = true                              //   should be used “true” if needs to use spot
}
```
5. Plan and Apply new node group

```
terraform plan -var-file=tfvars/filecoin-glif-dev-apn1.tfvars

terraform apply -var-file=tfvars/filecoin-glif-dev-apn1.tfvars
```
----------

### Create secret to AWS

1. Go to the repo [terraform](https://github.com/glifio/filecoin-iac)
2. cd **aws**/
3. Create initial check
```
   terraform init -backend-config=../filecoin-glif-dev-apn1.hcl
     
   terraform workspace list

   terraform workspace select ${workspace}
```
4. Select the file ***secrets_envs.tf***

```
resource "aws_secretsmanager_secret" "api_read_dev_lotus" {
count                   = local.is_dev_envs                                    // evnironment where will be create secret
name                    = "${module.generator.prefix}-api-read-dev-lotus"      // name of secret
recovery_window_in_days = 30

tags = merge({ "Name" = "${module.generator.prefix}-api-read-dev-lotus" },
module.generator.common_tags)
}
```
5. Plan and Apply new node group

```
terraform plan -var-file=tfvars/filecoin-glif-dev-apn1.tfvars

terraform apply -var-file=tfvars/filecoin-glif-dev-apn1.tfvars
```
6. Go to AWS account --> Secret Manager
7. Add key/value secrets manually
 ````
{
  "key": "value"
}
````
![Screenshot 2023-04-19 at 11.00.27.png](doc%2FScreenshot%202023-04-19%20at%2011.00.27.png)

----------

### Create secret to Kubernetes

All secrets are stored in AWS and then use by Kubernetes clusters
You can check it into this file **/aws/secrets_envs.tf**

!!! IF THE SECRET HAS ALREADY CREATED TO AWS !!!

1. Go to the repo [terraform](https://github.com/glifio/filecoin-iac)
2. cd **k8s**/
3. Create initial check
```
   terraform init -backend-config=../filecoin-glif-dev-apn1.hcl
     
   terraform workspace list

   terraform workspace select ${workspace}
```

Now needs to pass the secret object from directory AWS to directory K8S
should be used files **data.tf, secret.tf**

4. Select the file data.tf
````
data "aws_secretsmanager_secret" "api_read_dev_lotus" {
  count = local.is_dev_envs                                  // environment where will be create secret
  name  = "${module.generator.prefix}-api-read-dev-lotus"   //  name of secret object from AWS
}

data "aws_secretsmanager_secret_version" "api_read_dev_lotus" {
  count     = local.is_dev_envs                                         //  environment where will be create secret
  secret_id = data.aws_secretsmanager_secret.api_read_dev_lotus[0].id   //  data id for each key value from secret
}
````
5. Select the file secrets.tf

````
resource "kubernetes_secret_v1" "api_read_dev_lotus_secret" {
  count = local.is_dev_envs
  metadata {
    name      = "api-read-dev-lotus-secret"                          // name for kubernetes secret
    namespace = kubernetes_namespace_v1.network.metadata[0].name     // // namespace where will be create kubernetes secret
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_dev_lotus[0].secret_string), "private_key", null)  // private key which uses Lotus
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_dev_lotus[0].secret_string), "jwt_token", null)    // overridden custom jwt token with permissions
  }
}
````

7. Plan and Apply secrets for nodegroup

```
terraform plan -var-file=tfvars/filecoin-glif-dev-apn1.tfvars

terraform apply -var-file=tfvars/filecoin-glif-dev-apn1.tfvars
```

---------------

## Deploy Lotus with helm chart

1. Go to the repo [helm-chart](https://github.com/glifio/filecoin-chart)
2. make sure that your config context is correct

````
kubectl config use-context arn:aws:eks:ap-northeast-1:499623857295:cluster/filecoin-dev-apn1-glif-eks
````
3. cd **values/dev/network/**
4. create your configuration values.yaml file

   ```touch api-read-dev.yaml```

````
nodeSelector:
  nodeGroupName: group2

importSnapshot: true
downloadSnapshotUrl: "https://snapshots.mainnet.filops.net/minimal/latest.zst"
snapshotLocation: "/home/lotus_user/snapshot/latest.car"

lotusImageRepository: glif/lotus:v1.18.0

isSlaveNode: true
createLotusService: false
customReleaseName: api-read-dev

lotusEnv:
  LOTUS_VM_ENABLE_TRACING: "true"
  INFRA_LOTUS_GATEWAY: "true"

lotusRequestsCpu: 12
lotusRequestsMemory: 80Gi

lotusCpuLimit: 15
lotusMemoryLimit: 120Gi

isSpotInstance: true
createServiceRoleBinding: false
````
5. retunt to the root directory filecoin-charts

6. select **Makefile** which file include variables NODE,ENV,NAMESPACE for quickly deploy lotus config

![Screenshot 2023-04-18 at 14.57.21.png](doc%2FScreenshot%202023-04-18%20at%2014.57.21.png)

7. for next deploy make sure correct configuration
````
make diff 
````
8. Deploy new configuration to the kubernetes

````
make nodeInstall
````

----------------


## Scenario to deploy if the secret exists

1. Create nodegroup follow the example here [Create nodegroup](#create-nodegroup)

!!! IF THE SECRET HAS ALREADY CREATED TO AWS !!!

![Screenshot 2023-04-18 at 14.16.51.png](doc%2FScreenshot%202023-04-18%20at%2014.16.51.png)

 Should be added secret only for kubernetes
2. Create secret for nodegroup to kubernetes - follow the example here [Create secret to Kubernetes](#create-secret-to-kubernetes)
3. Deploy Lotus use helm charts - follow the example here [Deploy Lotus with helm chart](#deploy-lotus-with-helm-chart)

------------------

## Scenario to deploy with the new secret

1. Create nodegroup -  follow the example here [Create nodegroup](#create-nodegroup)

!!! IF THE SECRET HASN'T BEEN CREATED TO AWS !!!

// Lotus uses their own secrets, which change all the time.
We need to override Lotus secrets to our custom secrets.

2. Create secret for nodegroup to AWS - follow the example here [Create secret to AWS](#create-secret-to-aws)
   
***In this step, might secret is empty, the next step I'll show what needs to put to key-value***

3. Should deploy Lotus configuration - follow the example here [Deploy Lotus with helm chart](#deploy-lotus-with-helm-chart)
   and don't forget to change config.yaml as described

!!! In this step important disable variables connect with our secrets, because we need native Lotus secrets !!!

***useLotusSecret: false***
***INFRA_SECRETVOLUME: "false"***

   ```touch api-read-dev.yaml```

````
nodeSelector:
  nodeGroupName: group5

importSnapshot: true
downloadSnapshotUrl: "https://snapshots.mainnet.filops.net/minimal/latest.zst"
snapshotLocation: "/home/lotus_user/snapshot/latest.car"

lotusImageRepository: glif/lotus:v1.21.0-rpc-p01-custom-amd-limit

isSlaveNode: true
createLotusService: false
customReleaseName: api-read-dev
useLotusSecret: false

lotusEnv:
  LOTUS_VM_ENABLE_TRACING: "true"
  INFRA_LOTUS_GATEWAY: "true"
  INFRA_CLEAR_RESTART: "true"
  INFRA_SECRETVOLUME: "false"


lotusRequestsCpu: 12
lotusRequestsMemory: 80Gi

lotusCpuLimit: 15
lotusMemoryLimit: 120Gi

isSpotInstance: true
createServiceRoleBinding: false
````
#### how to find native Lotus secret 
 - Use node shell we need jwt-token, private_key

   ````kubectl -n network get po ````

 - kubectl exec -it my-pod --container main-app -- /bin/bash

````
kubectl -n network exec -it api-read-test-lotus-0 --container filecoin -- /bin/bash
 ````
 - cd ***/home/lotus_user/.lotus/keystore***   // native secret uses by Lotus

![Screenshot 2023-04-19 at 11.39.03.png](doc%2FScreenshot%202023-04-19%20at%2011.39.03.png)

 - use command 'cat' and find a "private_key" which we will put in "Secret Manager"

![Screenshot 2023-04-19 at 11.47.30.png](doc%2FScreenshot%202023-04-19%20at%2011.47.30.png)

 - cd ***/home/lotus_user/.lotus*** --> cat token

 -  Put in jwt-token to Secret Manager
 - If needs create custom jwt token - follow the example here [Create custom JWT token](#create-custom-jwt-token)

4. Create secret for nodegroup to kubernetes - follow the example here [Create secret to Kubernetes](#create-secret-to-kubernetes)
5. Deploy Lotus again with variables / or without variables in your config.yaml, because it's true by default
   ***useLotusSecret: true***
   ***INFRA_SECRETVOLUME: "true"***
   follow the example here [Deploy Lotus with helm chart](#deploy-lotus-with-helm-chart)
6. By the way if command "make nodeInstall" didn't work, please do make nodeReinit

-----------------

### Create custom token

1. Should be used app https://jwt.io/

- Encoded - currect lotus jwt token (Check Secret Manager, or into pod with Lotus  ***/home/lotus_user/.lotus*** )

![Screenshot 2023-04-18 at 11.19.02.png](doc%2FScreenshot%202023-04-18%20at%2011.19.02.png)

- verify signature - private lotus key (Check Secret Manager, or into pod with Lotus  ***/home/lotus_user/.lotus/keystore*** )

![Screenshot 2023-04-18 at 11.19.07.png](doc%2FScreenshot%202023-04-18%20at%2011.19.07.png)

- Payload - choose your permissions for jwt token

![Screenshot 2023-04-18 at 11.44.16.png](doc%2FScreenshot%202023-04-18%20at%2011.44.16.png)

-----------------

## Delete lotus nodes

Delete nodegroup

1. Go to the repo [helm-chart](https://github.com/glifio/filecoin-chart)
2. make sure that your config context is correct

````
kubectl config use-context arn:aws:eks:ap-northeast-1:499623857295:cluster/filecoin-dev-apn1-glif-eks
````
3. ```make diff```
4. ````make nodeDelete```` / ````make nodeDeleteFull```` - If pod uses ebs volume
5. Delete nodegroup [terraform](https://github.com/glifio/filecoin-iac)
6. cd ***aws/***
7. Commented or delete your nodegroup, commented secret for nodegroup to aws, commented secret for nodegroup into data.tf, secrets.tf to directory k8s
8. ```terraform plan -var-file=tfvars/filecoin-glif-dev-apn1.tfvars```
9. ```terraform apply -var-file=tfvars/filecoin-glif-dev-apn1.tfvars```
