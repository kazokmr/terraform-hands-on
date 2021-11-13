# Codepipelineの各ステージ間で受け渡しを行うArtifactの格納場所をS3に作成する
resource "aws_s3_bucket" "artifacts" {
  bucket = "artifacts.${var.bucket_common_name}"

  lifecycle_rule {
    enabled = true

    expiration {
      days = 180
    }
  }
}