resource "aws_db_subnet_group" "this" {
  count       = length(var.subnet_ids) > 0 ? 1 : 0
  name        = "${var.identifier}-subnet-group"
  subnet_ids  = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.identifier}-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier             = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  username               = var.username
  password               = var.password
  db_name                = var.db_name
  db_subnet_group_name   = length(var.subnet_ids) > 0 ? aws_db_subnet_group.this[0].name : null
  vpc_security_group_ids = var.security_groups
  publicly_accessible    = var.publicly_accessible
  multi_az               = var.multi_az
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot    = true

  tags = merge(var.tags, {
    Name = var.identifier
  })
}