# AWS RDS Module

Minimal RDS instance module. Provide credentials via variables (do not commit secrets).

Inputs: `identifier`, `username`, `password`, `instance_class`, `allocated_storage`, `tags`.
Outputs: `db_instance_id`, `db_endpoint`.
