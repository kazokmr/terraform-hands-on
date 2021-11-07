provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "./modules/network"
}
module "bucket" {
  source             = "./modules/s3_bucket"
  bucket_common_name = var.bucket_common_name
}
module "alb_dns" {
  source            = "./modules/elb_dns"
  vpc_id            = module.network.vpc_id
  alb_subnets       = [
    module.network.public_subnet_0_id,
    module.network.public_subnet_1_id,
  ]
  alb_log_bucket_id = module.bucket.alb_lob_bucket_id
  depends_on        = [module.bucket]
  host_zone_name    = var.host_zone_name
}
