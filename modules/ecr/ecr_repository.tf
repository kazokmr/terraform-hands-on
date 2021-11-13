# ECRリポジトリを定義
resource "aws_ecr_repository" "repo" {
  name = "repo"
}

# コンテナイメージのライフサイクルポリシー
resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.repo.name
  # 下記のポリシーは: Tagの先頭が"release"で始まるイメージの内30個を超えた分は古いイメージから順番に削除する
  policy = <<EOF
    {
    "rules":[
      {
        "rulePriority": 1,
        "description": "Keep last release tagged images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["release"],
          "countType": "imageCountMoreThan",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
  EOF
}
