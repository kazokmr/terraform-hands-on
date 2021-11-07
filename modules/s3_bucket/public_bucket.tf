#パブリックバケットの定義
resource "aws_s3_bucket" "public" {

  # バケット名は全世界で一意としないと作られない
  bucket = "public.kazokmr.net"

  # 読み取りのみパブリックアクセスを許可(デフォルトはS3バケットを作成したAWSアカウントのみアクセス化)
  acl = "public-read"

  # CORSの許可設定: 例としてkazokmr.netからのGETメソッドのみ許可している
  cors_rule {
    allowed_origins = ["https://kazokmr.net"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    max_age_seconds = 3000
  }
}