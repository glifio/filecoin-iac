project         = "filecoin"
environment     = "mainnet"
region          = "ap-northeast-1"
sub_environment = "glif"
route53_domain  = "node.glif.io"
branch          = "main"


git_configuration = [
  {
    config = {
      project_name      = "fluent-bit",
      name              = "filecoin-external-snapshotter"
      organization_name = "glifio",
      description       = "CI/CD pipeline for filecoin",
      repo_name         = "filecoin-fluent-bit",
    }
  },
  {
    config = {
      project_name      = "cid-checker",
      name              = "cid-checker"
      organization_name = "glifio",
      environment       = "mainnet",
      description       = "CI/CD pipeline for filecoin",
      repo_name         = "cid-checker",
    }
  },
]
