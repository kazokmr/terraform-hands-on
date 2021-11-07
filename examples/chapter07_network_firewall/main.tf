provider "aws" {
  region = "ap-northeast-1"
}

module "example_network" {
  source = "../../modules/network"
}

module "example_sg" {
  source      = "../../modules/security_group"
  name        = "example-sg"
  vpc_id      = module.example_network.vpc_id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

# moduleでOutputしているオブジェクトはapplyで実行するファイルでも定義しないとコンソールには出力されない
output "vpc_id" {
  value = module.example_network.vpc_id
}
output "public_subnet_0" {
  value = module.example_network.public_subnet_0_id
}
output "public_subnet_1" {
  value = module.example_network.public_subnet_1_id
}
output "private_subnet_0" {
  value = module.example_network.private_subnet_0_id
}
output "private_subnet_1" {
  value = module.example_network.private_subnet_1_id
}
output "nat_gateway_eip_0" {
  value = module.example_network.nat_gateway_0_ip
}
output "nat_gateway_eip_1" {
  value = module.example_network.nat_gateway_1_ip
}
