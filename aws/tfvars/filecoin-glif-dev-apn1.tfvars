project         = "filecoin"
environment     = "dev"
region          = "ap-northeast-1"
sub_environment = "glif"
route53_domain  = "dev.node.glif.io"
branch          = "dev"


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
      project_name      = "fil-wallaby-lotus",
      name              = "fil-wallaby-lotus"
      organization_name = "witnsby",
      description       = "CI/CD pipeline for filecoin",
      repo_name         = "fil-wallaby-lotus",
    }
  },
]
