resource "random_string" "uid" {
  length  = 5
  lower   = true
  upper   = false
  special = false
}
