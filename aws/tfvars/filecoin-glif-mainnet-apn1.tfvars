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
      project_name      = "wallaby",
      name              = "wallaby"
      organization_name = "protofire",
      description       = "CI/CD pipeline for a filecoin wallaby application",
      repo_name         = "wallaby",
    }
  },
  {
    config = {
      project_name      = "hyperspace",
      name              = "hyperspace"
      organization_name = "filecoin-project",
      description       = "CI/CD pipeline for a filecoin hyperspace application",
      repo_name         = "lotus",
    }
  },
  {
    config = {
      project_name      = "api-read-mirror",
      name              = "api-read-mirror"
      organization_name = "filecoin-project",
      description       = "CI/CD pipeline for a filecoin mainnet mirror application",
      repo_name         = "lotus",
    }
  },
  {
    config = {
      project_name      = "cid-checker",
      name              = "cid-checker"
      organization_name = "protofire",
      description       = "CI/CD pipeline for filecoin",
      repo_name         = "filecoin-CID-checker",
    }
  },
]
