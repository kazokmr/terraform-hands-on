# タスクの管理を行うECSサービスの定義
resource "aws_ecs_service" "ecs_service" {
  name                              = "ecs_service"
  cluster                           = aws_ecs_cluster.ecs_cluster.arn
  task_definition                   = aws_ecs_task_definition.task_definition.arn
  desired_count                     = 2         # 維持するタスク数
  launch_type                       = "FARGATE" # 起動タイプをFargateにする
  platform_version                  = "1.4.0"   # Fargateのプラットフォームバージョン(1.4.0は現在の最新)
  health_check_grace_period_seconds = 60        # コンテナ起動からヘルスチェックを開始するまでの猶予時間(sec)

  # タスクのネットワーク構成:今回はPrivateサブネットで起動させる
  network_configuration {
    assign_public_ip = false
    security_groups  = [module.nginx_sg.security_group_id]
    subnets          = var.private_subnets
  }

  # タスクと関連付けるALBを指定する
  load_balancer {
    target_group_arn = var.alb_target_group_ecs_arn
    container_name   = "web" # ALBから最初にフォワードされるコンテナ名を指定する
    container_port   = 80
  }

  # タスク定義の変更を無視する: Fargateはデプロイの度にタスク定義が更新されるのでTerraformで変更ありとみなされるため
  lifecycle {
    ignore_changes = [task_definition]
  }
}

# ECSサービスに対するSecurity Groupの作成
module "nginx_sg" {
  source      = "../security_group"
  name        = "nginx-sg"
  vpc_id      = var.vpc_id
  port        = 80
  cidr_blocks = var.vpc_cider_block
}