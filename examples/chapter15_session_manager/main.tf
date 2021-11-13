provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "../../modules/network"
}

module "ssm_session_manager" {
  source              = "../../modules/ssm_manager"
  bucket_common_name  = var.bucket_common_name
  private_subnet_0_id = module.network.private_subnet_0_id
}