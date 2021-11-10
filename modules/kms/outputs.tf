output "kms_key_arn" {
  value = aws_kms_key.customer_master_key.arn
}