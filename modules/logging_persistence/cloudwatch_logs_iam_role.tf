# CloudWatch Logsに付けるロールを定義
module "cloudwatch_logs_role" {
  source     = "../iam_role"
  name       = "cloudwatch-logs"
  identifier = "logs.ap-northeast-1.amazonaws.com"
  policy     = data.aws_iam_policy_document.cloudwatch_logs.json
}

data "aws_iam_policy_document" "cloudwatch_logs" {
  # 東京リージョンに構築した全てのfirehoseオブジェクトへの操作を許可する
  statement {
    effect    = "Allow"
    actions   = ["firehose:*"]
    resources = ["arn:aws:firehose:ap-northeast-1:*:*"]
  }

  # 指定した名前を持つロールにPassRole権限を付ける
  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::*:role/cloudwatch-logs"]
  }
}