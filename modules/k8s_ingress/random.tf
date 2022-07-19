resource "random_string" "rand" {
  length  = 5
  lower   = true
  number  = true
  special = false
  upper   = false
}
