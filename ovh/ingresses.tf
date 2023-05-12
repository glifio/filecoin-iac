module "ingress_spacenet_daemon" {
  count = local.production

  name   = "spacenet-daemon"
  source = "../modules/ovh_ingress"

  http_host = "spacenet.node.glif.io"
  http_path = "/lotus/(.*)"

  service_name = "spacenet-lotus-service"
  service_port = 1234

  enable_public_access = true
  secret_name          = "filecoin-mainnet-apn1-glif-spacenet"
}
