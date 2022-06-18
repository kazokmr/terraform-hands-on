#プライベートバケットの定義
resource "aws_s3_bucket" "private" {

  # バケット名は全世界で一意としないと作られない
  bucket = "private.${var.bucket_common_name}"

  force_destroy = true # デモなのでファイルがあっても強制削除を可能にする
}

# バージョンニングの有効化
resource "aws_s3_bucket_versioning" "private_bucket_versioning" {
  bucket = aws_s3_bucket.private.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

# 暗号化: AES256で暗号化する
resource "aws_s3_bucket_server_side_encryption_configuration" "private_bucket_encryption" {
  bucket = aws_s3_bucket.private.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# パブリックアクセスをブロックする
resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.private.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}