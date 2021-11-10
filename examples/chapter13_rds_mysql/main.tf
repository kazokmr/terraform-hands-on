provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "../../modules/network"
}

module "kms" {
  source = "../../modules/kms"
}

module "rds_mysql" {
  source              = "../../modules/rds"
  vpc_id              = module.network.vpc_id
  vpc_cidr_blocks     = [module.network.vpc_cider_block]
  private_subnet_0_id = module.network.private_subnet_0_id
  private_subnet_1_id = module.network.private_subnet_1_id
  kms_key_arn         = module.kms.kms_key_arn
  database_password   = "DummyPassword"
}