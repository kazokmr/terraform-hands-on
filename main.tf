terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.19"
    }
  }
  required_version = "1.3.3"
}

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
  source         = "./modules/elb_dns"
  vpc_id         = module.network.vpc_id
  public_subnets = [
    module.network.public_subnet_0_id,
    module.network.public_subnet_1_id,
  ]
  alb_log_bucket_id = module.bucket.alb_lob_bucket_id
  depends_on        = [module.bucket]
  host_zone_name    = var.host_zone_name
}
module "ecs" {
  source          = "./modules/ecs"
  vpc_id          = module.network.vpc_id
  vpc_cider_block = [module.network.vpc_cider_block]
  private_subnets = [
    module.network.private_subnet_0_id,
    module.network.private_subnet_1_id,
  ]
  alb_target_group_ecs_arn   = module.alb_dns.alb_target_group_ecs_arn
  container_definitions_path = var.container_definitions_path
}
module "batch" {
  source                           = "./modules/batch"
  ecs_task_execution_iam_role_arn  = module.ecs.ecs_task_execution_iam_role_arn
  batch_container_definitions_path = var.batch_container_definitions_path
  ecs_cluster_arn                  = module.ecs.ecs_cluster_arn
  private_subnets                  = [
    module.network.private_subnet_0_id,
  ]
}
module "kms" {
  source = "./modules/kms"
}
module "ssm_parameters" {
  source              = "./modules/ssm_parameters"
  db_username         = var.db_username
  db_initial_password = var.db_initial_password
}