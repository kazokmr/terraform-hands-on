provider "aws" {
  region = "ap-northeast-1"
}
module "ecr" {
  source = "../../modules/ecr/"
}
