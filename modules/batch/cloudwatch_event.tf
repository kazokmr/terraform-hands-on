# ECSを起動するためのポリシー: AWS標準のポリシーを利用する
data "aws_iam_policy" "ecs_events_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
}

# CloudwatchイベントからECSを起動するためのIAMロールを定義
module "ecs_events_role" {
  source     = "../iam_role"
  name       = "ecs-events"
  identifier = "events.amazonaws.com"
  policy     = data.aws_iam_policy.ecs_events_role_policy.policy
}

# Cloudwatchイベントのルール作成: 2分おきに実行する
resource "aws_cloudwatch_event_rule" "batch" {
  name                = "batch_rule"
  description         = "バッチ処理のデモ"
  schedule_expression = "cron(*/2 * * * ? *)" # cron式はCloudwatchイベントのスケジュール式(分 時 日 月 曜日 年)に準じる。Timezoneは常にUTC
}

# Cloudwatchイベントのターゲット(実行対象ジョブ)を定義
resource "aws_cloudwatch_event_target" "batch_job" {
  target_id = "batch-job"
  rule      = aws_cloudwatch_event_rule.batch.name
  role_arn  = module.ecs_events_role.iam_role_arn
  arn       = var.ecs_cluster_arn
  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    platform_version    = "1.4.0"
    task_definition_arn = aws_ecs_task_definition.batch_task.arn
    network_configuration {
      assign_public_ip = "false"
      subnets          = var.private_subnets
    }
  }
}