resource "ovh_cloud_project_kube" "default" {
  service_name = local.service_name
  name         = "${module.generator.prefix}-ipc-node-hosting"
  region       = var.ovh_region
}
