# nodegroups

## Summary

This module provides resources to create and configure EKS nodegroup:
- EC2 instances of the nodegroups can be of different types (e.g. on-demand and spot) and sizes, and it is possible to deploy application to the specific instance using a `nodeGroup` selector.
- The secret for the nodegroups and kubernetes can use as existed or as generated secret by python script [main.py](https://github.com/glifio/filecoin-iac/blob/ci-cd-for-nodegroups/k8s/main.py).
- The ingress rule for kong *http and ipfs*.
- The kong plugins combined plugin with requests transformers URI  & headers.

## Usage example

````
module "eks_nodegroup_ondemand_${name}" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/nodegroups"
  ami_type                                = "AL2_ARM_64"
  get_instance_type                       = "r6gd.4xlarge"
  user_data_script                        = "nvme-spot.sh"
  get_nodegroup_name                      = "${name}" # don't need to type ondemand/spot in the name, it will be added automatically.
  get_global_configuration                = local.make_global_configuration
  get_eks_nodegroups_global_configuration = local.make_eks_nodegroups_global_configuration
  get_namespace                           = kubernetes_namespace_v1.network.metadata[0].name

  # create ingress for http #
  http_host            = "node.glif.io"
  http_path            = "/${name}/(.*)"
  service_port         = 1234
  type_lb_scheme       = "external"
  enable_public_access = true        
  false_auth           = true        # if value `true` kong plugin should be use "Authorization: false

  # create ingress for ipfs  #
  create_ingress_kong_ipfs = false
  #  http_path_ipfs                        = "/${name}/ipfs/4001/(.*)"
  #  service_port_ipfs                     = 4001

  # create secret #
   from_secret = "filecoin-mainnet-aps1-glif-calibration" 
}

````




## Resources

| Name                                                                                                                                                                                      | Type |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|
| [aws_eks_node_group.nodegroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group)                                                                | resource |
| [aws_iam_role.eks_nodegroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                                        | resource |
| [aws_iam_role_policy_attachment.eks_nodegroup_AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_nodegroup_AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)          | resource |
| [aws_iam_role_policy_attachment.eks_nodegroup_AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)               | resource |
| [aws_key_pair.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair)                                                                             | resource |
| [aws_launch_template.lt_ondemand](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)                                                            | resource |
| [aws_launch_template.lt_spot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)                                                                | resource |
| [aws_security_group.eks_nogroup_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                                           | resource |
| [aws_security_group_rule.eks_sgr_egress_itself](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)                                          | resource |
| [aws_security_group_rule.eks_sgr_egress_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)                                           | resource |
| [aws_security_group_rule.eks_sgr_ingress_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)                                       | resource |
| [aws_security_group_rule.eks_sgr_ingress_http_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)                                  | resource |
| [aws_security_group_rule.eks_sgr_ingress_itself](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)                                         | resource |
| [aws_security_group_rule.eks_sgr_ingress_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)                                            | resource |
| [random_string.nodegroup_name_postfix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)                                                             | resource |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet)                                                                              | data source |
| [external.secret_generator](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external)                                                                 | data source |
| [aws_secretsmanager_secret.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret)                                                       | resource |
| [aws_secretsmanager_secret_version.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version)                                    | resource |
| [kubernetes_secret_v1.main](https://registry.terraform.io/providers/hashicorp/kubernetes/2.4.1/docs/resources/secret)                                                                     | resource |
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                                                                     | resource |
| [kubernetes_ingress_v1.ingress_kong](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1)                                                            | resource |
| [kubernetes_ingress_v1.ingress_kong_ipfs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1)                                                     | resource |
| [kubernetes_manifest.request_transformer-public_access](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest)                                                                          | resource |
| [kubernetes_manifest.request_transformer-path_transformer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest)                                                                          | resource |
| [kubernetes_manifest.request_transformer-combined_transformer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest)                                                                          | resource |
| [kubernetes_manifest.cors](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest)                                                                          | resource |




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | For on-demand instances used the AWS Graviton2 made Arm-based use the type AMI `AL2_ARM_64`. For spot instances used default value. | `string` | `"AL2_x86_64"` | no |
| <a name="input_assign_to_archive_node"></a> [assign\_to\_archive\_node](#input\_assign\_to\_archive\_node) | If value `TRUE` assign archive pods only on archival nodes. | `bool` | `false` | no |
| <a name="input_auth_token_attribute"></a> [auth\_token\_attribute](#input\_auth\_token\_attribute) | Attribute of secret to auth token from. | `string` | `"jwt_token_kong_rw"` | no |
| <a name="input_availability_zone_postfix"></a> [availability\_zone\_postfix](#input\_availability\_zone\_postfix) | Availability zone to deploy the nodegroup to. | `string` | `"a"` | no |
| <a name="input_create_aws_secret"></a> [create\_aws\_secret](#input\_create\_aws\_secret) | Create secret in AWS. | `bool` | `true` | no |
| <a name="input_create_ingress_kong"></a> [create\_ingress\_kong](#input\_create\_ingress\_kong) | If true, creating ingress. | `bool` | `true` | no |
| <a name="input_create_ingress_kong_ipfs"></a> [create\_ingress\_kong\_ipfs](#input\_create\_ingress\_kong\_ipfs) | If true, creating ingress for ipfs. | `bool` | `true` | no |
| <a name="input_create_k8s_secret"></a> [create\_k8s\_secret](#input\_create\_k8s\_secret) | Create secret in Kubernetes. | `bool` | `true` | no |
| <a name="input_create_secret"></a> [create\_secret](#input\_create\_secret) | n/a | `bool` | `true` | no |
| <a name="input_ebs_tenant"></a> [ebs\_tenant](#input\_ebs\_tenant) | Tenant tag value to search EBS volumes by. | `string` | `null` | no |
| <a name="input_enable_cors"></a> [enable\_cors](#input\_enable\_cors) | If true, enable CORS policy. | `bool` | `true` | no |
| <a name="input_enable_path_transformer"></a> [enable\_path\_transformer](#input\_enable\_path\_transformer) | If true, transform path as specified in replace\_path\_rule. | `bool` | `true` | no |
| <a name="input_enable_public_access"></a> [enable\_public\_access](#input\_enable\_public\_access) | If true, add Authorization header. | `bool` | `false` | no |
| <a name="input_enable_return_json"></a> [enable\_return\_json](#input\_enable\_return\_json) | If true, add Content-Type: application/json header to response. | `bool` | `true` | no |
| <a name="input_enable_switch_transformer"></a> [enable\_switch\_transformer](#input\_enable\_switch\_transformer) | If true, switch the path as specified in any switch\_path. | `bool` | `false` | no |
| <a name="input_false_auth"></a> [false\_auth](#input\_false\_auth) | If true, kong plugin using to section with token the `Authorization: false` | `bool` | `true` | no |
| <a name="input_from_secret"></a> [from\_secret](#input\_from\_secret) | Secret to copy secret\_string from. | `string` | `""` | no |
| <a name="input_get_desired_size"></a> [get\_desired\_size](#input\_get\_desired\_size) | Desired number of instances in the scaling group. | `number` | `1` | no |
| <a name="input_get_eks_nodegroups_global_configuration"></a> [get\_eks\_nodegroups\_global\_configuration](#input\_get\_eks\_nodegroups\_global\_configuration) | Set of basic inputs  to EKS cluster and networking settings. | `any` | n/a | yes |
| <a name="input_get_global_configuration"></a> [get\_global\_configuration](#input\_get\_global\_configuration) | Set of inputs used by module generator for the naming. | `any` | n/a | yes |
| <a name="input_get_instance_type"></a> [get\_instance\_type](#input\_get\_instance\_type) | List of instance types associated with the EKS Node Group. Defaults to on-demand [`r6gd.4xlarge`], to spot [`m5d.8xlarge,r5ad.8xlarge`] | `string` | n/a | yes |
| <a name="input_get_max_size"></a> [get\_max\_size](#input\_get\_max\_size) | Maximum number of instances in the scaling group. | `number` | `2` | no |
| <a name="input_get_min_size"></a> [get\_min\_size](#input\_get\_min\_size) | Minimum number of instances in the scaling group. | `number` | `1` | no |
| <a name="input_get_namespace"></a> [get\_namespace](#input\_get\_namespace) | Kubernetes namespace. | `any` | n/a | yes |
| <a name="input_get_nodegroup_name"></a> [get\_nodegroup\_name](#input\_get\_nodegroup\_name) | Name of the nodegroup. | `string` | `null` | no |
| <a name="input_get_whitelist_ips"></a> [get\_whitelist\_ips](#input\_get\_whitelist\_ips) | n/a | `list` | <pre>[<br>  "212.58.119.174",<br>  "91.149.128.236",<br>  "216.144.250.150",<br>  "69.162.124.224/28",<br>  "63.143.42.240/28",<br>  "216.245.221.80/28",<br>  "46.137.190.132",<br>  "122.248.234.23",<br>  "188.226.183.141",<br>  "178.62.52.237",<br>  "54.79.28.129",<br>  "54.94.142.218",<br>  "104.131.107.63",<br>  "54.67.10.127",<br>  "54.64.67.106",<br>  "159.203.30.41",<br>  "46.101.250.135",<br>  "18.221.56.27",<br>  "52.60.129.180",<br>  "159.89.8.111",<br>  "146.185.143.14",<br>  "139.59.173.249",<br>  "165.227.83.148",<br>  "128.199.195.156",<br>  "138.197.150.151",<br>  "34.233.66.117"<br>]</pre> | no |
| <a name="input_http_host"></a> [http\_host](#input\_http\_host) | HTTP host to match. | `string` | `null` | no |
| <a name="input_http_path"></a> [http\_path](#input\_http\_path) | HTTP path to match. | `string` | `null` | no |
| <a name="input_http_path_ipfs"></a> [http\_path\_ipfs](#input\_http\_path\_ipfs) | HTTP path to match. | `string` | `null` | no |
| <a name="input_http_path_type"></a> [http\_path\_type](#input\_http\_path\_type) | HTTP path comparison type. | `string` | `"Exact"` | no |
| <a name="input_is_spot_instance"></a> [is\_spot\_instance](#input\_is\_spot\_instance) | If value `TRUE` run the launch template for spot. | `bool` | `false` | no |
| <a name="input_k8s_secret_postfix"></a> [k8s\_secret\_postfix](#input\_k8s\_secret\_postfix) | Postfix of the Kubernetes secret. | `string` | `"-lotus-secret"` | no |
| <a name="input_name"></a> [name](#input\_name) | Secret name. | `string` | `""` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | SSH key that provides access for remote communication with the instances. | `string` | `"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMC7lI58Is6qjyARyNAJw9jm/LWcmjXsIZL5t2urMcl common alexey_kulik"` | no |
| <a name="input_replace_path_rule"></a> [replace\_path\_rule](#input\_replace\_path\_rule) | Regular expression to transform the path. | `string` | `"/$(uri_captures[1])"` | no |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Backend service port. | `number` | `null` | no |
| <a name="input_service_port_ipfs"></a> [service\_port\_ipfs](#input\_service\_port\_ipfs) | If provided , ingress for ipfs should be use service port for ipfs. | `string` | `null` | no |
| <a name="input_type_lb_scheme"></a> [type\_lb\_scheme](#input\_type\_lb\_scheme) | If external, ingress has to go on external LB. | `string` | `"external"` | no |
| <a name="input_use_existing_ebs"></a> [use\_existing\_ebs](#input\_use\_existing\_ebs) | If true, EBS volumes matching ebs\_tenant will be attached on launch. | `bool` | `false` | no |
| <a name="input_user_data_script"></a> [user\_data\_script](#input\_user\_data\_script) | Runs the scripts for creates a RAID on the volumes. | `string` | `"nvme.sh"` | no |
