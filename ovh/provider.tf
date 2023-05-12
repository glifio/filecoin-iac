provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "local" {}

provider "ovh" {
  endpoint           = local.endpoint
  application_key    = local.application_key
  application_secret = local.application_secret
  consumer_key       = local.consumer_key
}

provider "helm" {
  kubernetes {
    host                   = ovh_cloud_project_kube.default.kubeconfig_attributes[0].host
    client_certificate     = base64decode(ovh_cloud_project_kube.default.kubeconfig_attributes[0].client_certificate)
    cluster_ca_certificate = base64decode(ovh_cloud_project_kube.default.kubeconfig_attributes[0].cluster_ca_certificate)
    client_key             = base64decode(ovh_cloud_project_kube.default.kubeconfig_attributes[0].client_key)
  }
}

provider "kubernetes" {
  host                   = ovh_cloud_project_kube.default.kubeconfig_attributes[0].host
  client_certificate     = base64decode(ovh_cloud_project_kube.default.kubeconfig_attributes[0].client_certificate)
  cluster_ca_certificate = base64decode(ovh_cloud_project_kube.default.kubeconfig_attributes[0].cluster_ca_certificate)
  client_key             = base64decode(ovh_cloud_project_kube.default.kubeconfig_attributes[0].client_key)
}
