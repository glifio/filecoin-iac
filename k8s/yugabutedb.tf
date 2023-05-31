resource "helm_release" "yugabutedb-api_read_dev" {
  name      = "api-read-dev-db"
  namespace = "network"

  repository = "https://charts.yugabyte.com"
  chart      = "yugabyte"
  version    = "2.17.3"

  values = [
    file("${path.module}/configs/yugabytedb/values.yaml")
  ]

  set {
    name  = "nodeSelector.app"
    value = "api-read-dev"
  }

  set {
    name  = "nodeSelecor.purpose"
    value = "db"
  }

  max_history = 2
}
