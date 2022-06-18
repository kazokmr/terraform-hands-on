#パブリックバケットの定義
resource "aws_s3_bucket" "public" {

  # バケット名は全世界で一意としないと作られない
  bucket = "public.${var.bucket_common_name}"

  force_destroy = true # デモなのでファイルがあっても強制削除を可能にする
}

# 読み取りのみパブリックアクセスを許可(デフォルトはS3バケットを作成したAWSアカウントのみアクセス化)
resource "aws_s3_bucket_acl" "public_bucket_acl" {
  bucket = aws_s3_bucket.public.bucket
  acl    = "public-read"
}

# CORSの許可設定: 例としてkazokmr.netからのGETメソッドのみ許可している
resource "aws_s3_bucket_cors_configuration" "public_bucket_cors" {
  bucket = aws_s3_bucket.public.bucket
  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["https://example.com"]
    allowed_headers = ["*"]
    max_age_seconds = 3000
  }
}