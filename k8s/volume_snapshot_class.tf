# Links about Volume Snapshots:
# https://kubernetes.io/docs/concepts/storage/volume-snapshot-classes
# https://aws.amazon.com/blogs/containers/using-ebs-snapshots-for-persistent-storage-with-your-eks-cluster/
resource "kubernetes_manifest" "volume_snapshot_class" {
  count = local.is_prod_envs

  manifest = {
    "apiVersion" = "snapshot.storage.k8s.io/v1"
    "kind"       = "VolumeSnapshotClass"
    "metadata" = {
      "name" = "ebs-csi-aws"
    }
    "driver"         = "ebs.csi.aws.com"
    "deletionPolicy" = "Delete"
  }
}
