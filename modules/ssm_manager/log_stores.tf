# S3でログを保存する場合のバケットを定義
resource "aws_s3_bucket" "operation" {
  bucket        = "operation.${var.bucket_common_name}"
  force_destroy = true # デモなので強制削除を有効
}

# バケットデータのライフサイクルを定義
resource "aws_s3_bucket_lifecycle_configuration" "operation_lifecycle" {
  bucket = aws_s3_bucket.operation.bucket
  rule {
    id     = "operation"
    status = "Enabled"
    expiration {
      days = 180
    }
  }
}

# CloudWatch Logsで保存する場合の定義
resource "aws_cloudwatch_log_group" "operation" {
  name              = "/operation"
  retention_in_days = 180
}