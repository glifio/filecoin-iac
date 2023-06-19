module "api_read_dev_worker_http_ingress" {
  count = local.is_dev_envs

  name   = "http-api-read-dev-worker"
  source = "../modules/ovh_ingress"

  namespace = "network"

  incress_class = "kong-external-lb"

  http_host = "cluster.dev.node.glif.io"
  http_path = "/(.*)"

  service_name = "api-read-dev-worker-lotus-service"
  service_port = 1234

  secret_name = module.api-read-dev-worker-secret[0].aws_secret_name

  enable_access_control = true
  access_control_public = true
  enable_letsencrypt    = false
}
