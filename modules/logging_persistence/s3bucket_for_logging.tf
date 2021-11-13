# CloudWatch Logsのログの保管先となるS3バケットを定義
resource "aws_s3_bucket" "cloudwatch_logs" {
  bucket = "cloudwatch-logs.${var.bucket_common_name}"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }

  force_destroy = true # デモなのでファイルがあっても強制削除を可能にする
}