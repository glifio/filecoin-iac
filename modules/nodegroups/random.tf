resource "random_string" "nodegroup_name_postfix" {
  length  = 5
  lower   = true
  upper   = false
  special = false
}

resource "random_string" "rand" {
  length  = 5
  lower   = true
  numeric = true
  special = false
  upper   = false
}
