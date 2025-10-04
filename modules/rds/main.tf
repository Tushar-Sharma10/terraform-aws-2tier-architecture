## RELATIONAL DATABSE

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.project_name}-group"
  subnet_ids = var.subnet_ids

  tags = {
    Project = var.project_name
    Env     = var.environment
  }

}
resource "aws_db_instance" "db_instance" {
  db_name                         = var.db_name
  instance_class                  = var.instance_class
  username                        = var.db_username
  password                        = var.db_password
  engine                          = var.engine
  engine_version                  = var.engine_version
  allocated_storage               = var.allocated_storage
  db_subnet_group_name            = aws_db_subnet_group.subnet_group.name
  max_allocated_storage           = var.max_allocated_storage
  apply_immediately               = var.apply_immediately
  delete_automated_backups        = var.delete_automated_backups
  database_insights_mode          = var.database_insights_mode
  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports
  multi_az                        = var.multi_az
  network_type                    = var.network_type
  port                            = var.port
  publicly_accessible             = var.publicly_accessible
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.skip_final_snapshot ? null : var.final_snapshot_identifier
  depends_on                      = [aws_db_subnet_group.subnet_group]


  tags = {
    Project = var.project_name
    Env     = var.environment
  }

}