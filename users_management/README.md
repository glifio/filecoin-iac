# user_management

## Summary

This module provides resources to create and configure IAM users, groups and policies, as well as Kubernetes users and permissions.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.2.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.30.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.6.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.13.1 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.30.0 |
| <a name="provider_kubernetes.k8s_cluster_mainnet"></a> [kubernetes.k8s\_cluster\_mainnet](#provider\_kubernetes.k8s\_cluster\_mainnet) | 2.13.1 |
| <a name="provider_kubernetes.k8s_cluster_testnet"></a> [kubernetes.k8s\_cluster\_testnet](#provider\_kubernetes.k8s\_cluster\_testnet) | 2.13.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_generator_dev"></a> [generator\_dev](#module\_generator\_dev) | ../modules/generator | n/a |
| <a name="module_generator_global"></a> [generator\_global](#module\_generator\_global) | ../modules/generator | n/a |
| <a name="module_generator_mainnet"></a> [generator\_mainnet](#module\_generator\_mainnet) | ../modules/generator | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_account_password_policy.main](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_group.devops](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.preprod_devops](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.devops](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.devops_group](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.manage_own_credentials](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_policy) | resource |
| [aws_iam_user.users](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_user) | resource |
| [kubernetes_config_map_v1_data.users_list_mainnet](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/config_map_v1_data) | resource |
| [kubernetes_config_map_v1_data.users_list_testnet](https://registry.terraform.io/providers/hashicorp/kubernetes/2.13.1/docs/resources/config_map_v1_data) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.k8s_cluster_mainnet](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster.k8s_cluster_testnet](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.k8s_cluster_auth_mainnet](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/data-sources/eks_cluster_auth) | data source |
| [aws_eks_cluster_auth.k8s_cluster_auth_testnet](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_profile"></a> [profile](#input\_profile) | n/a | `string` | `"filecoin"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_sub_environment"></a> [sub\_environment](#input\_sub\_environment) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
