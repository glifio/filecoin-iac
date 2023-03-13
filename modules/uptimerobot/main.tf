# Create a monitor
resource "uptimerobot_monitor" "main" {
  friendly_name = "wallaby.node.glif.io"
  type          = "http"
  url           = "https://wallaby.node.glif.io/rpc/v0"
  interval      = "1"
}
