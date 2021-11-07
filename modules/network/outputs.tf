# 作成したVPC IDを出力: outputを定義しておくと他のModuleから参照できるようになる
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cider_block" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnet_0_id" {
  value = aws_subnet.public_0.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_1.id
}

output "private_subnet_0_id" {
  value = aws_subnet.private_0.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_1.id
}

output "nat_gateway_0_ip" {
  value = aws_eip.nat_gateway_0.public_ip
}

output "nat_gateway_1_ip" {
  value = aws_eip.nat_gateway_1.public_ip
}
