resource "aws_db_instance" "this" {
  identifier     = var.identifier
  engine         = var.engine
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  db_name        = var.db_name
  username       = var.username
  password       = var.password
  skip_final_snapshot = var.skip_final_snapshot
  tags           = var.tags
}
