# Kinesis data firehose delivery stream による配信定義
resource "aws_kinesis_firehose_delivery_stream" "demo" {
  name        = "demo"
  destination = "s3" # 配信先をS3としその設定は下記の通り
  s3_configuration {
    role_arn   = module.kinesis_data_firehose_role.iam_role_arn
    bucket_arn = aws_s3_bucket.cloudwatch_logs.arn
    prefix     = "ecs-scheduled-tasks/demo/" # S3に書き込むときのプレフィックス。chapter10のバッチで構築したECSのログが対象なので。
  }
}