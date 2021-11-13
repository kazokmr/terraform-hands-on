# ログローテーションバケットの定義
resource "aws_s3_bucket" "alb_log" {

  # バケット名は全世界で一意としないと作られない
  bucket = "alb-log.${var.bucket_common_name}"

  # バケット内のオブジェクトのライフサイクル
  lifecycle_rule {
    enabled = true

    # 180日を経過したオブジェクトを削除する
    expiration {
      days = "180"
    }
  }

  force_destroy = true # デモなのでファイルがあっても強制削除を可能にする
}

# S3バケットへのアクセス件を定義するバケットポリシー
resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

# ポリシードキュメント: 東京リージョンのELBからS3のログローテションバケットへの書き込みアクセス件を許可する
data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    # type > identifiers の順番に定義しないと正しく定義されないかも
    principals {
      type        = "AWS"
      identifiers = ["582318560864"] # ap-northeast-1 の ELB のアカウントID
    }
  }
}

# パブリックアクセスをブロックする
resource "aws_s3_bucket_public_access_block" "alb_log" {
  depends_on              = [aws_s3_bucket_policy.alb_log] # バケットポリシーの割り当てと競合するので後に実行する
  bucket                  = aws_s3_bucket.alb_log.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "alb_lob_bucket_id" {
  value = aws_s3_bucket.alb_log.id
}