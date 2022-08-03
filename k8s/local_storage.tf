#resource "kubernetes_storage_class_v1" "local_storage" {
#  metadata {
#    name = "local-storage"
#  }
#  storage_provisioner    = "kubernetes.io/no-provisioner"
#  reclaim_policy         = "Delete"
#  volume_binding_mode    = "WaitForFirstConsumer"
#  allow_volume_expansion = false
#}


resource "helm_release" "local_static_provisioner" {
  name       = "local-static-provisioner"
  repository = "https://github.com/kubernetes-sigs/sig-storage-local-static-provisioner/helm/"
  chart      = "provisioner"
  namespace  = "kube-system"
  version    = "2.5.0"

  set {
    name  = "classes.name"
    value = "local-storage"
  }

  set {
    name  = "classes.hostDir"
    value = "/nvme/disk"
  }

  set {
    name = "classes.fsType"
    value = "xfs"
  }

}
