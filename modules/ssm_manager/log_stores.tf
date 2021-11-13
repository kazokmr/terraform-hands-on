# S3でログを保存する場合のバケットを定義
resource "aws_s3_bucket" "operation" {
  bucket = "operation.${var.bucket_common_name}"

  lifecycle_rule {
    enabled = true
    expiration {
      days = 180
    }
  }

  force_destroy = true # デモなので強制削除を有効
}

# CloudWatch Logsで保存する場合の定義
resource "aws_cloudwatch_log_group" "operation" {
  name              = "/operation"
  retention_in_days = 180
}