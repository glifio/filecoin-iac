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
      project_name      = "api-read-amd64",
      name              = "api-read-amd64"
      organization_name = "filecoin-project",
      description       = "CI/CD pipeline for a filecoin mainnet amd64 application",
      repo_name         = "lotus",
    }
  },
  {
    config = {
      project_name      = "api-read-arm64",
      name              = "api-read-arm64"
      organization_name = "protofire",
      description       = "CI/CD pipeline for a filecoin mainnet arm64 application",
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
  {
    config = {
      project_name      = "spacenet-amd64",
      name              = "spacenet-amd64"
      organization_name = "consensus-shipyard",
      description       = "CI/CD pipeline for a filecoin spacenet amd64 application",
      repo_name         = "lotus",
    }
  }
]
