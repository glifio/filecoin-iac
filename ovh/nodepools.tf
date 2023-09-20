resource "ovh_cloud_project_kube_nodepool" "spacenet" {
  service_name = local.service_name
  kube_id      = ovh_cloud_project_kube.default.id
  name         = "spacenet"
  flavor_name  = "c2-15"

  min_nodes = 0
  max_nodes = 2

  desired_nodes = 0
}

resource "ovh_cloud_project_kube_nodepool" "kong" {
  service_name = local.service_name
  kube_id      = ovh_cloud_project_kube.default.id
  name         = "kong"
  flavor_name  = "b2-7"

  min_nodes = 0
  max_nodes = 2

  desired_nodes = 0
}

resource "ovh_cloud_project_kube_nodepool" "monitoring" {
  service_name = local.service_name
  kube_id      = ovh_cloud_project_kube.default.id
  name         = "monitoring"
  flavor_name  = "b2-15"

  min_nodes = 0
  max_nodes = 2

  desired_nodes = 0
}
