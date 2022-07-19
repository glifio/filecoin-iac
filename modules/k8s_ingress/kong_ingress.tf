# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/service/nlb/
# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/service/annotations/ annotations

resource "kubernetes_ingress_v1" "ingress_kong" {
  metadata {
    name      = "kong-${var.get_ingress_backend_service_name}-${var.get_ingress_backend_service_port}-${random_string.rand.result}"
    namespace = var.get_ingress_namespace

    annotations = {
      "kubernetes.io/ingress.class" = "kong-${var.type_lb_scheme}-lb"
      "konghq.com/plugins"          = local.get_kong_list_plugins
      "konghq.com/protocols"        = "https, http"
    }
  }

  spec {
    rule {
      host = var.get_rule_host
      http {
        path {
          path      = var.get_ingress_http_path
          path_type = "Prefix"
          backend {
            service {
              name = var.as_is_ingress_backend_service_name ? var.get_ingress_backend_service_name : "${var.get_ingress_backend_service_name}-service"
              port {
                number = var.get_ingress_backend_service_port
              }
            }
          }
        }
      }
    }
  }
}





## this rule allows to connect from alb to ingress like a backend of alb
#resource "aws_security_group_rule" "cluster_security_group_1234" {
#  type                     = "ingress"
#  description              = "${module.generator.prefix} allow from alb ingress service to cluster security group"
#  from_port                = 1234
#  to_port                  = 1234
#  protocol                 = "tcp"
#  source_security_group_id = aws_security_group.alb_managed_ingress_sg.id
#  security_group_id        = data.aws_eks_cluster.k8s_cluster.vpc_config[0].cluster_security_group_id
#}
