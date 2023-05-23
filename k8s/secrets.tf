resource "kubernetes_secret_v1" "lotus_archive_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "calibrationapi-archive-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_archive_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_archive_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_archive_node_tmp_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "calibrationapi-archive-node-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_archive_node_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_archive_node_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_wallaby_archive_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "wallaby-archive-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_lotus[0].secret_string), "jwt_token", null)
    nodeid     = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_lotus[0].secret_string), "bootstrap_node_id", null)
  }
}

resource "kubernetes_secret_v1" "wallaby_archive_private_0_lotus" {
  count = local.is_prod_envs
  metadata {
    name      = "wallaby-archive-private-0-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_private_0_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_private_0_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_wallaby_archive_slave_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "wallaby-archive-slave-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_wallaby_archive_slave_1_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "wallaby-archive-slave-1-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.wallaby_archive_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_hyperspace_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "hyperspace-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    nodeid     = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "bootstrap_node_id", null)
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_hyperspace_mirror_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "hyperspace-mirror-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_hyperspace_slave_0_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "hyperspace-slave-0-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_hyperspace_slave_1_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "hyperspace-slave-1-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "lotus_hyperspace_slave_2_node_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "hyperspace-slave-2-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "hyperspace_private_0_lotus" {
  count = local.is_prod_envs
  metadata {
    name      = "hyperspace-private-0-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_private_0_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.hyperspace_private_0_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "calibrationapi_lotus_secret" {
  count = local.is_prod_envs
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
  count = local.is_prod_envs
  metadata {
    name      = "calibrationapi-jwt-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_jwt_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.calibrationapi_jwt_lotus[0].secret_string), "jwt_token", null)
  }
}


resource "kubernetes_secret_v1" "api_read_v0_cache_mainnet_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-v0-cache-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    config = base64decode(lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_v0_cache_mainnet[0].secret_string), "cache_service_config", null))
  }
}

resource "kubernetes_secret_v1" "api_read_master_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-master-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_mirror_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-mirror-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_mirror_2_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-mirror-2-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_0_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-0-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_1_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-1-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_2_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-2-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_3_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-3-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_4_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-4-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_5_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-5-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_6_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-6-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_7_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-7-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_8_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-8-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_9_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-9-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_10_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-10-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_11_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-11-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_12_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-12-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_13_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-13-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "api_read_slave_14_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "api-read-slave-14-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.api_read_master_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "space00_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "space00-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.space00_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.space00_mainnet_lotus[0].secret_string), "jwt_token", null)
    nodeid     = lookup(jsondecode(data.aws_secretsmanager_secret_version.space00_mainnet_lotus[0].secret_string), "bootstrap_node_id", null)

  }
}


resource "kubernetes_secret_v1" "space06_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "space06-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.space06_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.space06_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "space06_1_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "space06-1-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.space06_1_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.space06_1_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "space07_mainnet_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "space07-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.space07_mainnet_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.space07_mainnet_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "fvm_archive_lotus" {
  count = local.is_prod_envs
  metadata {
    name      = "fvm-archive-lotus-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    privatekey = lookup(jsondecode(data.aws_secretsmanager_secret_version.fvm_archive_lotus[0].secret_string), "private_key", null)
    token      = lookup(jsondecode(data.aws_secretsmanager_secret_version.fvm_archive_lotus[0].secret_string), "jwt_token", null)
  }
}

resource "kubernetes_secret_v1" "space06_cache_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "space06-cache-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    config = base64decode(lookup(jsondecode(data.aws_secretsmanager_secret_version.space06_cache_mainnet_lotus[0].secret_string), "cache_service_config", null))
  }
}

resource "kubernetes_secret_v1" "space07_cache_lotus_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "space07-cache-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    config = base64decode(lookup(jsondecode(data.aws_secretsmanager_secret_version.space07_cache_mainnet_lotus[0].secret_string), "cache_service_config", null))
  }
}

resource "kubernetes_secret_v1" "cid_checker_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "cid-checker-secret"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    mongoURL = lookup(jsondecode(data.aws_secretsmanager_secret_version.cid_checker[0].secret_string), "mongoURL", null)
  }
}

resource "kubernetes_secret_v1" "cid_checker_mainnet_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "cid-checker-mainnet-secret"
    namespace = "default"
  }
  data = {
    dbUsername = lookup(jsondecode(data.aws_secretsmanager_secret_version.cid_checker[0].secret_string), "dbUsername", null)
    dbPassword = lookup(jsondecode(data.aws_secretsmanager_secret_version.cid_checker[0].secret_string), "dbPassword", null)
  }
}

resource "kubernetes_secret_v1" "cid_checker_calibration_secret" {
  count = local.is_prod_envs
  metadata {
    name      = "cid-checker-calibration-secret"
    namespace = "default"
  }
  data = {
    dbUsername = lookup(jsondecode(data.aws_secretsmanager_secret_version.cid_checker_calibration[0].secret_string), "dbUsername", null)
    dbPassword = lookup(jsondecode(data.aws_secretsmanager_secret_version.cid_checker_calibration[0].secret_string), "dbPassword", null)
  }
}

resource "kubernetes_secret_v1" "github_ssh_gist_updater" {
  metadata {
    name      = "github-ssh-gist-updater"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  data = {
    ssh = base64decode(lookup(jsondecode(data.aws_secretsmanager_secret_version.github_ssh_gist_updater.secret_string), "ssh", null))
  }
}

resource "kubernetes_secret_v1" "gcp_credentials" {
  metadata {
    name      = "gcp-credentials"
    namespace = "network"
  }
  data = {
    "credentials.json" = jsondecode(data.aws_secretsmanager_secret_version.gcp_credentials.secret_string)["credentials"]
  }
}
