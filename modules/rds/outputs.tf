output "db_instance_id" {
  value = aws_db_instance.mysql.identifier
}

output "db_instance_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
