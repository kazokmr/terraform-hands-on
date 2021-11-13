# TerraformのGitHubプロバイダを宣言する
provider "github" {
  organization = var.github_name # GitHubのアカウント
}

# GitHubのWebhook設定を定義: AWS Codepipelineに送信するWebhook
resource "github_repository_webhook" "github_webhook" {
  repository = var.github_repo # 対象リポジトリ名
  events     = ["push"]        # Push時にWebhookを実行する
  configuration {
    url          = aws_codepipeline_webhook.demo.url # 呼び出し先となるCodepipelineのWebhook用URL
    secret       = var.github_token                  # 連携トークン
    content_type = "json"
    insecure_ssl = false
  }
}