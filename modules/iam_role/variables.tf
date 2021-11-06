# IAM Role と IAM Policy の名前
variable "name" {}
# ポリシードキュメント (aws_iam_policy_document)
variable "policy" {}
# IAM Roleに関連付けるAWSのサービス識別子
variable "identifier" {}
