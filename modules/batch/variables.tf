# ECSのタスク実行IAMロールのARN
variable "ecs_task_execution_iam_role_arn" {}

# ECSのバッチタスク定義JSONファイルのPath
variable "batch_container_definitions_path" {}

# ECSのクラスターARN
variable "ecs_cluster_arn" {}

# ECSタスクのPrivateサブネットリスト
variable "private_subnets" {
  type = list(string)
}
