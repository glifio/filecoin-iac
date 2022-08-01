locals {
  make_global_configuration = {
    project         = var.project
    region          = var.region
    environment     = var.environment
    sub_environment = var.sub_environment
  }

  make_eks_nodegroups_global_configuration = {
    cluster_name = aws_eks_cluster.main.name
    vpc_id       = aws_vpc.main.id
    cidr_blocks  = aws_vpc.main.cidr_block
    subnet_ids   = aws_subnet.public.*.id
  }

  enable_env_budget = {
    "filecoin-glif-dev-apn1"     = 1
    "filecoin-glif-mainnet-apn1" = 0
  }
  enable_env_budgets = local.enable_env_budget[terraform.workspace]

  key_usage       = "ENCRYPT_DECRYPT"
  key_spec        = "SYMMETRIC_DEFAULT"
  deletion_window = 7
  kms_enabled     = true
  key_rotation    = true

  is_dev_env = {
    filecoin-glif-dev-apn1     = 1
    filecoin-glif-mainnet-apn1 = 0
  }
  is_dev_envs = local.is_dev_env[terraform.workspace]

  is_mainnet_env = {
    filecoin-glif-dev-apn1     = 0
    filecoin-glif-mainnet-apn1 = 1
  }
  is_mainnet_envs = local.is_mainnet_env[terraform.workspace]

  make_codebuild_global_configuration = {
    project           = var.project
    region            = var.region
    environment       = var.environment
    sub_environment   = var.sub_environment
    aws_account_id    = data.aws_caller_identity.current.account_id
    branch            = var.branch
    git_configuration = var.git_configuration
  }
}
