# Create a monitor

resource "uptimerobot_monitor" "main" {
  friendly_name = "wallaby.node.glif.io"
  type          = "https"
  url           = "https://wallaby.node.glif.io/rpc/v0"
  interval      = "1"
  timeout       = "30s"
  ignore_ssl_errors = "true"
}
