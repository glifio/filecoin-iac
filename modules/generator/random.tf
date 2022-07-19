resource "random_string" "uid" {
  length  = 8
  lower   = true
  upper   = false
  special = false
}
