#########################################################

#TODO: think about sharing snapshots for apiread-nodes in the test env

############common service external##########################

module "ingress-kong_monitoring-80" {
  count                              = local.is_dev_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_backend_service_name   = "monitoring-grafana"
  get_ingress_pathType               = "Prefix"
  as_is_ingress_backend_service_name = true // if value is false then the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = kubernetes_namespace_v1.monitoring.metadata[0].name
  get_rule_host                      = "monitoring.dev.node.glif.io"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
  type_lb_scheme                     = "external"
}

module "ingress_api_read_dev" {
  count = local.is_dev_envs

  name   = "wss-read-dev"
  source = "../modules/ovh_ingress"

  namespace = "proteus-shield"

  http_host      = "wss.dev.node.glif.io"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "proteus-shield-proxy-svc"
  service_port = 8080

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.api_read_dev_lotus[0].name

  enable_path_transformer = false
  enable_return_json      = true
  enable_access_control   = false
}

module "ingress_auth_dev" {
  count = local.is_dev_envs

  name   = "auth-dev"
  source = "../modules/ovh_ingress"

  namespace = "default"

  http_host      = "auth.dev.node.glif.io"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "glif-auth-app-svc"
  service_port = 3000

  ingress_class = "kong-external-lb"

  enable_path_transformer = false
  enable_access_control   = false
  enable_return_json      = false
  enable_cors             = false

  enable_redirect   = true
  redirect_location = "https://api.dev.node.glif.io/"
}

resource "kubernetes_ingress_v1" "proofstore_dev" {
  count = local.is_dev_envs

  metadata {
    name      = "proofstore-dev"
    namespace = "proteus-shield"
  }

  spec {
    ingress_class_name = "kong-external-lb"

    rule {
      host = "proofstore.dev.node.glif.io"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "proteus-shield-proxy-svc"
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}

#############################################################
