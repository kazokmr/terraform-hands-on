provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "../../modules/network"
}
module "bucket" {
  source             = "../../modules/s3_bucket"
  bucket_common_name = var.bucket_common_name
}
module "alb_dns" {
  source = "../../modules/elb_dns"
  vpc_id = module.network.vpc_id
  public_subnets = [
    module.network.public_subnet_0_id,
    module.network.public_subnet_1_id,
  ]
  alb_log_bucket_id = module.bucket.alb_lob_bucket_id
  depends_on        = [module.bucket]
  host_zone_name    = var.host_zone_name
}
module "ecs" {
  source          = "../../modules/ecs"
  vpc_id          = module.network.vpc_id
  vpc_cider_block = [module.network.vpc_cider_block]
  private_subnets = [
    module.network.private_subnet_0_id,
    module.network.private_subnet_1_id,
  ]
  alb_target_group_ecs_arn   = module.alb_dns.alb_target_group_ecs_arn
  container_definitions_path = "../../${var.container_definitions_path}"
}
module "batch" {
  source                           = "../../modules/batch"
  ecs_task_execution_iam_role_arn  = module.ecs.ecs_task_execution_iam_role_arn
  batch_container_definitions_path = "../../${var.batch_container_definitions_path}"
  ecs_cluster_arn                  = module.ecs.ecs_cluster_arn
  private_subnets = [
    module.network.private_subnet_0_id,
  ]
}
module "logging" {
  source                    = "../../modules/logging_persistence"
  bucket_common_name        = var.bucket_common_name
  cloudwatch_log_group_name = module.batch.cloudwatch_log_group_for_ecs_scheduled_tasks_name
}
