# ECSサービスを配置するPrivateサブネットIDのリスト
variable "private_subnets" {
  type = list(string)
}
# ECSサービスと関連付けるALBのTarget Group
variable "alb_target_group_ecs_arn" {}

# ECSサービスに割り当てるVPCのID
variable "vpc_id" {}
# VPCのCIDR Blocks
variable "vpc_cider_block" {
  type = list(string)
}

# ECSタスク定義ファイルのPath
variable "container_definitions_path" {}
