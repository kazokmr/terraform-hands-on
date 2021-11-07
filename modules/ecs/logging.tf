# Cloudwatch Logsでログを収集する
resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/logs"
  retention_in_days = 180 # ログの保持期間
}
