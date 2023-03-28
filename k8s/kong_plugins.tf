resource "kubernetes_config_map" "kong_plugin-http_mirror" {
  metadata {
    name      = "kong-plugin-http-mirror"
    namespace = kubernetes_namespace_v1.kong.metadata[0].name
  }

  data = {
    for f in fileset(local.kong_plugins_locations.http_mirror, "*.lua") :
    f => file(join("/", [local.kong_plugins_locations.http_mirror, f]))
  }
}