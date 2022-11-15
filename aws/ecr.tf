resource "aws_ecr_repository" "fluent_bit_chart" {
  name                 = "${module.generator.prefix}-chart-fluent-bit"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = module.generator.common_tags
}

resource "aws_ecr_repository" "external_snapshotter_chart" {
  name                 = "${module.generator.prefix}-chart-external-snapshotter"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = module.generator.common_tags
}

resource "aws_ecr_repository" "cid_checker" {
  count                = local.is_prod_envs
  name                 = "${module.generator.prefix}-cid-checker"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = module.generator.common_tags
}
