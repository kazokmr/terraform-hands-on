# CloudWatch Logsのログの保管先となるS3バケットを定義
resource "aws_s3_bucket" "cloudwatch_logs" {
  bucket        = "cloudwatch-logs.${var.bucket_common_name}"
  force_destroy = true # デモなのでファイルがあっても強制削除を可能にする
}

resource "aws_s3_bucket_lifecycle_configuration" "cloudwatch_logs_lifecycle" {
  bucket = aws_s3_bucket.cloudwatch_logs.bucket
  rule {
    id     = "cloudwatch_logs"
    status = "Enabled"
    expiration {
      days = 180
    }
  }
}