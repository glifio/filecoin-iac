# TODO: to finish with regional STS https://docs.aws.amazon.com/eks/latest/userguide/configure-sts-endpoint.html
resource "aws_iam_role" "aws_load_balancer_controller" {
  name        = "${terraform.workspace}-aws-load-balancer-controller"
  description = "${terraform.workspace} aws load balancer controller"

  assume_role_policy = templatefile("${path.module}/templates/roles/oidc_aws_load_balancer_controller.pol.tpl", {
    aws_account_id     = data.aws_caller_identity.current.account_id
    oidc               = local.oidc_URL
    aws_region         = var.region
    lb_controller_name = var.lb_controller_name
  })

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-aws-load-balancer-controller"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name = "${terraform.workspace}-aws-load-balancer-controller"

  policy = file("${path.module}/templates/policies/aws_load_balancer_controller.pol.tpl")

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-aws-load-balancer-controller"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_policy" "aws_load_balancer_controller_additional" {
  name = "${terraform.workspace}-aws-load-balancer-controller-additional"

  policy = file("${path.module}/templates/policies/aws_load_balancer_controller_additional.pol.tpl")

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-aws-load-balancer-controller-additional"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "eks_controller_policy" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}

resource "aws_iam_role_policy_attachment" "eks_controller_policy_additional" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller_additional.arn
}

resource "kubernetes_service_account_v1" "alb_controller_service_account" {
  metadata {
    name      = var.lb_controller_name
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_load_balancer_controller.arn
    }

    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
    }
  }
}

# Helm chart url: https://github.com/kubernetes-sigs/aws-load-balancer-controller/tree/main/helm/aws-load-balancer-controller
resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "vpcId"
    value = data.aws_vpc.current.id
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "image.repository"
    value = "${local.get_registry_based_on_regions}/amazon/aws-load-balancer-controller"
  }

  set {
    name  = "image.tag"
    value = "v2.4.2"
  }

  set {
    name  = "clusterName"
    value = terraform.workspace
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account_v1.alb_controller_service_account.metadata[0].name
  }

  set {
    name  = "logLevel"
    value = "info"
  }
}
