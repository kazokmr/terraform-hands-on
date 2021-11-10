variable "vpc_id" {}
variable "vpc_cidr_blocks" {
  type = list(string)
}
variable "private_subnet_0_id" {}
variable "private_subnet_1_id" {}
variable "kms_key_arn" {}
variable "database_password" {}
