resource "ovh_cloud_project_kube_nodepool" "spacenet" {
  service_name = local.service_name
  kube_id      = ovh_cloud_project_kube.default.id
  name         = "spacenet"
  flavor_name  = "b2-30"

  min_nodes = 1
  max_nodes = 2

  desired_nodes = 1
}

resource "ovh_cloud_project_kube_nodepool" "kong" {
  service_name = local.service_name
  kube_id      = ovh_cloud_project_kube.default.id
  name         = "kong"
  flavor_name  = "b2-7"

  min_nodes = 1
  max_nodes = 2

  desired_nodes = 1
}
