# nodegroups


## Summary

This module provides the most crucial parts of the infrastructure eks_nodegroup, secrets, ingress rules, kong plugins

## Module's example

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
  false_auth           = true        # if value `true` kong plugin should be use "Authorization: auth_token 

  # create ingress for ipfs  #
  create_ingress_kong_ipfs = false
  #  http_path_ipfs                        = "/${name}/ipfs/4001/(.*)"
  #  service_port_ipfs                     = 4001

  # create secret #
   from_secret = "filecoin-mainnet-aps1-glif-calibration"  # should be use secret from exist

}

````

This module provides resources to create and configure EKS nodegroup:
- EC2 instances of the nodegroups can be of different types (e.g. on-demand and spot) and sizes, and it is possible to deploy application to the specific instance using a `nodeGroup` selector.
- The secret for the nodegroups and kubernetes can use as existed or as generated secret by python script [main.py](https://github.com/glifio/filecoin-iac/blob/ci-cd-for-nodegroups/k8s/main.py).
- The ingress rule for kong *http and ipfs*.
- The route53 for kong ingress 
- The kong plugins combined plugin with requests transformers URI  & headers.
      #TODO - in addition, the plugin switched-transformer for switching between any ingress with adds needs jwt token.

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
| <a name="input_availability_zone_postfix"></a> [availability\_zone\_postfix](#input\_availability\_zone\_postfix) | Availability zone to deploy the nodegroup to | `string` | `"a"` | no |
| <a name="input_get_desired_size"></a> [get\_desired\_size](#input\_get\_desired\_size) | Desired number of instances in scaling group | `number` | `1` | no |
| <a name="input_get_eks_nodegroups_global_configuration"></a> [get\_eks\_nodegroups\_global\_configuration](#input\_get\_eks\_nodegroups\_global\_configuration) | Basic EKS cluster and networking settings | `any` | n/a | yes |
| <a name="input_get_global_configuration"></a> [get\_global\_configuration](#input\_get\_global\_configuration) | Basic AWS settings | `any` | n/a | yes |
| <a name="input_get_instance_type"></a> [get\_instance\_type](#input\_get\_instance\_type) | Instance types of EC2 instances | `any` | n/a | yes |
| <a name="input_get_max_size"></a> [get\_max\_size](#input\_get\_max\_size) | Maximum instances in scaling group | `number` | `2` | no |
| <a name="input_get_min_size"></a> [get\_min\_size](#input\_get\_min\_size) | Minimum instances in scaling group | `number` | `1` | no |
| <a name="input_get_nodegroup_name"></a> [get\_nodegroup\_name](#input\_get\_nodegroup\_name) | Name of the nodegroup | `string` | `null` | no |
| <a name="input_is_spot_instance"></a> [is\_spot\_instance](#input\_is\_spot\_instance) | se spot instances if `true` | `bool` | `false` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | SSH key to instances | `string` | `"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMC7lI58Is6qjyARyNAJw9jm/LWcmjXsIZL5t2urMcl"` | no |
