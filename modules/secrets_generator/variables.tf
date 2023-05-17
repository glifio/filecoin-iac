variable "generator_config" {
  type        = map(any)
  description = "Configuration for the prefix generator"
}

variable "name" {
  type        = string
  description = "Secret name"
}

variable "create_k8s_secret" {
  type        = bool
  default     = true
  description = "Create secret in Kubernetes"
}

variable "k8s_secret_postfix" {
  type        = string
  default     = "-lotus-secret"
  description = "Postfix of the Kubernetes secret"
}

variable "namespace" {
  type        = string
  default     = "network"
  description = "Namespace of the Kubernetes secret"
}
