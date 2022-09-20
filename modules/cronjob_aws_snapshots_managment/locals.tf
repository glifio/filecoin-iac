locals {
    full_pvc_name = "${var.volume_name_prefix}-${var.sts_name}-${var.volume_name_postfix}"
}