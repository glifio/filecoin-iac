resource "random_string" "nodegroup_name_postfix" {
  length  = 5
  lower   = true
  upper   = false
  special = false
}
