resource "kubernetes_config_map" "kong_plugin-http_mirror" {
  metadata {
    name      = "kong-plugin-http-mirror"
    namespace = kubernetes_namespace_v1.kong.metadata[0].name
  }

  data = {
    "access.lua"  = "${file("./kong_plugins/http_mirror/access.min.lua")}"
    "handler.lua" = "${file("./kong_plugins/http_mirror/handler.min.lua")}"
    "schema.lua"  = "${file("./kong_plugins/http_mirror/schema.min.lua")}"
  }
}

resource "kubernetes_config_map" "kong_plugin-external_auth" {
  metadata {
    name      = "kong-plugin-external-auth"
    namespace = kubernetes_namespace_v1.kong.metadata[0].name
  }

  data = {
    "handler.lua" = "${file("./kong_plugins/external_auth/handler.min.lua")}"
    "schema.lua"  = "${file("./kong_plugins/external_auth/schema.min.lua")}"
  }
}
