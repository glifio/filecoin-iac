variable "volume_name_prefix" {
  type    = string
  default = "vol-lotus"
}

variable "volume_name_postfix" {
  type    = string
  default = "lotus-0"
}

variable "sts_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "snaps_to_keep" {
  type = number
}

variable "creator_cron" {
  type    = string
  default = "0 0 * * *"
}

variable "deleter_cron" {
  default = "0 1 * * * "
}

variable "is_suspended" {
  type        = bool
  default     = false
  description = "Suspend the cronjob if true"
}
