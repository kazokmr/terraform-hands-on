provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "../../modules/network"
}

module "redis" {
  source              = "../../modules/elasticache"
  vpc_id              = module.network.vpc_id
  vpc_cidr_blocks     = [module.network.vpc_cider_block]
  private_subnet_0_id = module.network.private_subnet_0_id
  private_subnet_1_id = module.network.private_subnet_1_id
}
