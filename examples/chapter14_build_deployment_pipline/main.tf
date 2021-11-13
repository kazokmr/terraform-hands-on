provider "aws" {
  region = "ap-northeast-1"
}
module "ecr" {
  source = "../../modules/ecr/"
}

module "codebuild" {
  source = "../../modules/codebuild"
}
