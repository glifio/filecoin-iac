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

resource "kubernetes_storage_class_v1" "ebs_csi_driver_io2" {
  metadata {
    name = "ebs-sc-io2"
  }
  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  allow_volume_expansion = "false"
  volume_binding_mode    = "WaitForFirstConsumer"
  parameters = {
    type                        = "io2"
    "csi.storage.k8s.io/fstype" = "ext4"
    iopsPerGB                   = 1
    encrypted                   = "false"
  }
  mount_options = []
}

resource "kubernetes_storage_class_v1" "ebs_local_storage" {
  metadata {
    name = "local-storage"
  }
  storage_provisioner = "kubernetes.io/no-provisioner"
  volume_binding_mode = "WaitForFirstConsumer"
}

resource "kubernetes_storage_class_v1" "ebs_csi_driver_gp3" {
  metadata {
    name = "ebs-sc-gp3"
  }
  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"
  parameters = {
    type       = "gp3"
    encrypted  = "false"
    iops       = "3000"
    throughput = "256"
  }
  mount_options = []
}
