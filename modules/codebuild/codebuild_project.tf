# CodeBuildの定義: CodeBuildのベースになるプロジェクトを定義する。またCodePipelineとの連携を有効にする
resource "aws_codebuild_project" "demo" {
  name         = "demo"
  service_role = module.codebuild_role.iam_role_arn

  # ビルド対象ソースの指定: CodePipeline のソースステージ と連携する
  source {
    type = "CODEPIPELINE"
  }

  # ビルドしたアーティファクトの出力先: CodePipeline のアーティファクトストア と連携する
  artifacts {
    type = "CODEPIPELINE"
  }

  # ビルド実行環境
  environment {
    type            = "LINUX_CONTAINER"
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0" # AWSが管理するUbuntu20ベースのイメージ
    privileged_mode = true                         # ビルド時にDockerコマンドの利用を有効にする
  }
}