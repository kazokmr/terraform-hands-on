#プライベートバケットの定義
resource "aws_s3_bucket" "private" {

  # バケット名は全世界で一意としないと作られない
  bucket = "private.${var.bucket_common_name}"

  # バージョンニングの有効化
  versioning {
    enabled = true
  }

  # 暗号化: AES256で暗号化する
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# パブリックアクセスをブロックする
resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.private.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}