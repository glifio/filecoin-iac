resource "random_string" "rand" {
  length  = 5
  lower   = true
  numeric = true
  special = false
  upper   = false
}
