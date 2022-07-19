resource "aws_iam_role" "aws_ebs_csi_driver" {
  name        = "${terraform.workspace}-aws-ebs-csi-driver"
  description = "${terraform.workspace} aws ebs csi driver"

  assume_role_policy = templatefile("${path.module}/templates/roles/oidc_aws_ebs_csi_driver.pol.tpl", {
    aws_account_id      = data.aws_caller_identity.current.account_id
    oidc                = local.oidc_URL
    aws_region          = var.region
    ebs_controller_name = var.ebs_controller_name
  })

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-aws-ebs-csi-driver"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "eks_ebs_csi_driver_policy" {
  role       = aws_iam_role.aws_ebs_csi_driver.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "kubernetes_service_account_v1" "ebs_csi_driver_service_account" {
  metadata {
    name      = var.ebs_controller_name
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_ebs_csi_driver.arn
    }

    labels = {
      "app.kubernetes.io/component" = var.ebs_controller_name
      "app.kubernetes.io/name"      = var.ebs_controller_name
    }
  }
}

## Chart variables: https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/charts/aws-ebs-csi-driver/values.yaml
#
resource "helm_release" "ebs_csi_driver_service_account_gp2" {
  name       = "aws-ebs-csi-driver-gp2"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  version    = "2.6.9"

  set {
    name  = "controller.serviceAccount.create"
    value = "false"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = var.ebs_controller_name
  }

  ## We have this dependency because AWS requires it here: https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi.html
  ## A section is Important. To use the snapshot functionality of the Amazon EBS CSI drive ...
  depends_on = [
    helm_release.external-snapshotter
  ]
}

resource "kubernetes_storage_class_v1" "ebs_csi_driver_gp2" {
  metadata {
    name = "ebs-sc-gp2"
  }
  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  allow_volume_expansion = "true"
  volume_binding_mode    = "WaitForFirstConsumer"
  parameters = {
    type      = "gp2"
    encrypted = "false"
  }
  mount_options = []
}
