# IAM Role と IAM Policy定義を汎用的に利用するためのモジュール

# IAMポリシーの作成: ポリシードキュメントは変数 policy で取得する
resource "aws_iam_policy" "default" {
  name   = var.name
  policy = var.policy
}

# 信頼ポリシーの定義: 変数 identifier に渡されたサービスリストに関連づけられる
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [var.identifier]
      type        = "Service"
    }
  }
}

# IAM Role の定義: ポリシー定義に関連したIAM Roleを作成する
resource "aws_iam_role" "default" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAM Policy のアタッチ: 作成したIAM Role に IAM Policy を関連付ける
resource "aws_iam_role_policy_attachment" "default" {
  policy_arn = aws_iam_policy.default.arn
  role       = aws_iam_role.default.name
}
