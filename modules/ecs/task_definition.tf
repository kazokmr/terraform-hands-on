#タスク定義: タスクはコンテナの実行単位(複数のコンテナサービスの集合体でクラスタやサービスはタスクを冗長化している)
resource "aws_ecs_task_definition" "task_definition" {
  family                   = "web"                                       # タスク定義名のプレフィックス
  cpu                      = "256"                                       # CPUユニットの整数表現(1024 = 1コア相当)または、vCPUの文字列表現(1vCPU)
  memory                   = "512"                                       # MiBの整数表現(1024)または、GBの文字列表現(1GB)
  network_mode             = "awsvpc"                                    # 起動タイプがFargateなら、awsvpcを指定する
  requires_compatibilities = ["FARGATE"]                                 # 起動タイプ: Fargate か EC2を指定する
  container_definitions    = file(var.container_definitions_path)        # コンテナの定義ファイルのPath
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn # CloudWatch Logsへのアクセスロールを付与
}