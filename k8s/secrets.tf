resource "kubernetes_secret_v1" "lotus_archive_node_secret" {
  count = local.is_dev_envs
  metadata {
    name      = "calibrationapi-archive-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_archive_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_archive_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "calibrationapi_lotus_secret" {
  count = local.is_dev_envs
  metadata {
    name      = "calibrationapi-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_dev_lotus_secret" {
  count = local.is_dev_envs
  metadata {
    name      = "api-read-dev-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_dev_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_dev_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_cache_dev_lotus_secret" {
  count = local.is_dev_envs
  metadata {
    name      = "api-read-cache-dev-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    config = base64decode(lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_cache_dev[0].secret_string), "cache_service_config", null))
  }
}

resource "kubernetes_secret_v1" "calibrationapi_jwt_lotus_secret" {
  count = local.is_dev_envs
  metadata {
    name      = "calibrationapi-jwt-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_jwt_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_jwt_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_cache_mainnet_lotus_secret" {
  count = local.is_mainnet_envs
  metadata {
    name      = "api-read-cache-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    config = base64decode(lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_cache_mainnet[0].secret_string), "cache_service_config", null))
  }
}

resource "kubernetes_secret_v1" "api_read_master_mainnet_lotus_secret" {
  count = local.is_mainnet_envs
  metadata {
    name      = "api-read-master-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}
