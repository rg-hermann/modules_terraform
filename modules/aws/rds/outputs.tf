output "db_instance_id" {
  description = "DB instance identifier"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "DB instance ARN"
  value       = aws_db_instance.this.arn
}

output "endpoint" {
  description = "DB instance endpoint"
  value       = aws_db_instance.this.endpoint
}

output "port" {
  description = "DB instance port"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.this.db_name
}

output "username" {
  description = "Master username"
  value       = aws_db_instance.this.username
}