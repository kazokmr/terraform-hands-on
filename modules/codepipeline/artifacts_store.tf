# Codepipelineの各ステージ間で受け渡しを行うArtifactの格納場所をS3に作成する
resource "aws_s3_bucket" "artifacts" {
  bucket = "artifacts.${var.bucket_common_name}"
  force_destroy = true
}

# Artifact Bucketのライフサイクル設定
resource "aws_s3_bucket_lifecycle_configuration" "artifacts_lifecycle" {

  bucket = aws_s3_bucket.artifacts.bucket
  rule {
    id     = "artifacts"
    status = "Enabled"
    expiration {
      days = 180
    }
  }
}