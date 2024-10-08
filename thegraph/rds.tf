resource "aws_db_instance" "default" {
  allocated_storage   = var.rds_allocated_storage
  db_name             = "thegraph"
  engine              = var.rds_engine
  engine_version      = var.rds_engine_version
  instance_class      = var.rds_instance_class
  username            = lookup(jsondecode(data.aws_secretsmanager_secret_version.rds_credentials.secret_string), "username", null)
  password            = lookup(jsondecode(data.aws_secretsmanager_secret_version.rds_credentials.secret_string), "password", null)
  publicly_accessible = true
}
