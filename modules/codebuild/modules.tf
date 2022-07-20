module "generator" {
  source          = "../../modules/generator"
  project         = local.get_project
  region          = local.get_region
  environment     = local.get_environment
  sub_environment = local.get_sub_environment
}

//module "export_resource_ids_ci" {
//  count        = local.web_hook_ci_only
//  source          = "../../modules/export_resource_ids"
//  resource_object = aws_iam_role.codebuild_role
//  resource_type   = "iam_role"
//  name            = "codebuild_ci"
//  prefix          = module.generator.prefix
//  tags            = module.generator.common_tags
//}
//
//module "export_resource_ids" {
//  count        = local.web_hook_cicd
//  source          = "../../modules/export_resource_ids"
//  resource_object = aws_iam_role.codebuild_role
//  resource_type   = "iam_role"
//  name            = "codebuild"
//  prefix          = module.generator.prefix
//  tags            = module.generator.common_tags
//}
