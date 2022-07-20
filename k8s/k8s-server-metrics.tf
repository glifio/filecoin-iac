#https://artifacthub.io/packages/helm/metrics-server/metrics-server

resource "helm_release" "server_metrics" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
}
