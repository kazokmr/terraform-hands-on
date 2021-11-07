# バッチ用のECS向けのCloudwatch Logを定義
resource "aws_cloudwatch_log_group" "for_ecs_scheduled_tasks" {
  name = "/ecs-scheduled-tasks/demo"
}
