# Codepipelineが受け取るWebhookを定義する: GitHubからのリクエストに対応している
resource "aws_codepipeline_webhook" "demo" {
  name            = "demo"
  target_pipeline = aws_codepipeline.demo.name
  target_action   = "Source" # pipelineの実行アクション

  # GitHubとの認証
  authentication = "GITHUB_HMAC"
  authentication_configuration {
    secret_token = var.github_token
  }

  # Webhookの起動条件: pipelineで指定したブランチの場合だけ処理する
  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
}