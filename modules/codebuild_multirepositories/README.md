# codebuild_miltirepositories

## Summary

This module provides resources to spin up AWS CodeBuild for multiple repositories.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_badge_enabled"></a> [badge\_enabled](#input\_badge\_enabled) | Enable badge | `bool` | `true` | no |
| <a name="input_build_timeout"></a> [build\_timeout](#input\_build\_timeout) | Build timeot | `number` | `40` | no |
| <a name="input_buildspec_logic"></a> [buildspec\_logic](#input\_buildspec\_logic) | n/a | `string` | `null` | no |
| <a name="input_codebuild_image"></a> [codebuild\_image](#input\_codebuild\_image) | Which image of AWS CideBuild to use | `string` | `"aws/codebuild/standard:6.0"` | no |
| <a name="input_concurrent_build_limit"></a> [concurrent\_build\_limit](#input\_concurrent\_build\_limit) | Limit on the concurrent builds | `number` | `1` | no |
| <a name="input_concurrent_build_limit_default"></a> [concurrent\_build\_limit\_default](#input\_concurrent\_build\_limit\_default) | Default limit for non-concurrent builds | `number` | `10` | no |
| <a name="input_environment_compute_type"></a> [environment\_compute\_type](#input\_environment\_compute\_type) | CodeBuild [compute type](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html) | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_get_global_configuration"></a> [get\_global\_configuration](#input\_get\_global\_configuration) |  Basic AWS configuration  | `any` | n/a | yes |
| <a name="input_get_webhhok_custom_type"></a> [get\_webhhok\_custom\_type](#input\_get\_webhhok\_custom\_type) | n/a | `string` | `null` | no |
| <a name="input_git_repository_name"></a> [git\_repository\_name](#input\_git\_repository\_name) | Git repository to build | `any` | n/a | yes |
| <a name="input_github_cd_token_secret"></a> [github\_cd\_token\_secret](#input\_github\_cd\_token\_secret) | GitHub token, currently unused | `string` | `"github_cd_token_secret"` | no |
| <a name="input_is_build_concurrent"></a> [is\_build\_concurrent](#input\_is\_build\_concurrent) | Is the build concurrent | `bool` | `true` | no |
| <a name="input_is_build_only"></a> [is\_build\_only](#input\_is\_build\_only) | Creates a webhook if `true` | `bool` | `false` | no |
| <a name="input_notifications_enabled"></a> [notifications\_enabled](#input\_notifications\_enabled) | Enable codebuild notifications via SNS | `bool` | `true` | no |
| <a name="input_privileged_mode"></a> [privileged\_mode](#input\_privileged\_mode) | Enables running the Docker daemon inside a Docker container | `bool` | `false` | no |
| <a name="input_specific_branch"></a> [specific\_branch](#input\_specific\_branch) | Build on the specified branch | `string` | `null` | no |
| <a name="input_terraform_policy"></a> [terraform\_policy](#input\_terraform\_policy) | Currently unused | `bool` | `false` | no |
| <a name="input_webhhok_custom_type"></a> [webhhok\_custom\_type](#input\_webhhok\_custom\_type) | n/a | `bool` | `false` | no |
