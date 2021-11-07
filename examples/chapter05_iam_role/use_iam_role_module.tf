# 例) IAM Role モジュールを使って、リージョン一覧を閲覧する権限を定義する
module "describe_regions_for_ec2" {
  source = "../../modules/iam_role/"

  # iam_role/iam_role.tf に指定されている変数をセットする
  name       = "describe-regions-for-ec2"
  policy     = data.aws_iam_policy_document.allow_describe_regions.json
  identifier = "ec2.amazonaws.com"
}

# 例)ポリシードキュメント: 全てのリリースで、EC2のリージョン一覧を取得することを許可
data "aws_iam_policy_document" "allow_describe_regions" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeRegions"]
    resources = ["*"]
  }
}
