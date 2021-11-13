# CloudWatch Logsのサブスクリプションフィルタを定義
resource "aws_cloudwatch_log_subscription_filter" "demo" {
  name            = "demo"
  log_group_name  = var.cloudwatch_log_group_name                 # 送信するロググループを指定
  destination_arn = aws_kinesis_firehose_delivery_stream.demo.arn # 送信先のKinesis Data Firehose 配信ストリームを指定
  filter_pattern  = "[]"                                          # フィルタリングの指定はなし
  role_arn        = module.cloudwatch_logs_role.iam_role_arn
}