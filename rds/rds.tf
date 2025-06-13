resource "aws_rds_cluster" "aurora_pg" {
  cluster_identifier      = "deuna-aurora-${var.environment}"
  engine                  = "aurora-postgresql"
  master_username         = var.pgadmin_username
  master_password         = var.pgadmin_password
  kms_key_id              = var.kms_key_arn
  storage_encrypted       = true
  backup_retention_period = 7
  skip_final_snapshot     = false
  tags = { Environment = var.environment }
}

resource "aws_rds_cluster_instance" "this" {
  count              = 1
  identifier         = "aurora-${var.environment}-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_pg.id
  instance_class     = "db.serverless"
  engine             = "aurora-postgresql"
}