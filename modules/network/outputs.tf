# 作成したVPC IDを出力: outputを定義しておくと他のModuleから参照できるようになる
output "vpc_id" {
  value = aws_vpc.example.id
}