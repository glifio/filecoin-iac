locals {
  eks_cluster_testnet = "${module.generator_dev.prefix}-eks"
  eks_cluster_mainnet = "${module.generator_mainnet.prefix}-eks"
}
