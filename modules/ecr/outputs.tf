# ECR Repository の name属性値: データソースを取得する際のKey
output "ecr_repository_name" {
  value = aws_ecr_repository.repo.name
}
# ECR Repository の URL
output "ecr_repository_url" {
  value = aws_ecr_repository.repo.repository_url
}
