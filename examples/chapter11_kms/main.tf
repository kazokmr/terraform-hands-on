provider "aws" {
  region = "ap-northeast-1"
}

module "kms" {
  source = "../../modules/kms"
}
