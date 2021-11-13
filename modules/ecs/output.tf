# IAMロールのARN: ECSのタスク実行権限 + SSMとKMS
output "ecs_task_execution_iam_role_arn" {
  value = module.ecs_task_execution_role.iam_role_arn
}

# ECSクラスタのARN
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.ecs_service.name
}