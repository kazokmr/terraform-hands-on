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
