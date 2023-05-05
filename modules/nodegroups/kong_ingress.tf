# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/service/nlb/
# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/service/annotations/ annotations

resource "kubernetes_ingress_v1" "ingress_kong" {
  metadata {
	name      = "kong-${var.get_nodegroup_name}-lotus-service-${var.get_ingress_backend_service_port}-${random_string.rand.result}"
	namespace = var.get_namespace

	annotations = {
	  "konghq.com/plugins"          = local.get_kong_list_plugins
	  "konghq.com/protocols"        = "https, http"
	}
  }

  spec {
	ingress_class_name = "kong-${var.type_lb_scheme}-lb"
	rule {
	  host = var.get_rule_host
	  http {
		path {
		  path      = "/${var.get_nodegroup_name}/lotus/(.*)"
		  path_type = var.get_ingress_pathType
		  backend {
			service {
			  name = "${var.get_nodegroup_name}-lotus-service"
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



