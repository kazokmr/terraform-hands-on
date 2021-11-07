# ECSタスク実行ロールを取得: AWSが用意しているIAMポリシーを利用する(次のポリシードキュメント定義の基底として使う)
data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECSタスク実行のためのポリシードキュメントを定義: ECSタスク実行ポリシーを継承する
data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  # ECSタスク実行ポリシーに加え、SSMのパラメータアクセスとKMSの複号権限の許可を追加
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

# 作成したポリシードキュメントを参照してECS実行のためのIAMロールを定義する
module "ecs_task_execution_role" {
  source     = "../iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}
