module "codebuild_ipc_amd64" {
  count  = local.is_prod_envs
  source = "../modules/codebuild_ipc"

  generator_inputs = local.make_global_configuration

  project_name        = "ipc-amd64"
  project_description = "CodeBuild project for IPC tools and images"

  github_org    = "consensus-shipyard"
  github_repo   = "ipc"
  github_branch = "main"

  env_compute_type = "BUILD_GENERAL1_LARGE"
  env_image        = "aws/codebuild/standard:7.0"

  buildspec = file("${path.module}/templates/codebuild/ipc_amd64.yaml")

  s3_bucket = "glif-ipc"
}


resource "aws_s3_bucket" "glif_ipc" {
  count  = local.is_prod_envs
  bucket = "glif-ipc"
}


resource "aws_s3_bucket_public_access_block" "glif_ipc" {
  count  = local.is_prod_envs
  bucket = aws_s3_bucket.glif_ipc[0].id

  block_public_acls   = false
  block_public_policy = false
}
