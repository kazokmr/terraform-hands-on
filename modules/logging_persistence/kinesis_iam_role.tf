# Kinesis Data Firehose で使うIAMロールを定義
module "kinesis_data_firehose_role" {
  source     = "../iam_role"
  name       = "kinesis-data-firehose"
  identifier = "firehose.amazonaws.com"
  policy     = data.aws_iam_policy_document.kinesis_data_firehose.json
}

# ポリシードキュメントを定義
data "aws_iam_policy_document" "kinesis_data_firehose" {
  statement {
    effect = "Allow"

    # S3へのアクセスと書込み権限を付与
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]

    # 権限の対象はCloudWatch Logsのログを保管するS3バケットとその配下のオブジェクトに限定する
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.cloudwatch_logs.id}",
      "arn:aws:s3:::${aws_s3_bucket.cloudwatch_logs.id}/*",
    ]
  }
}