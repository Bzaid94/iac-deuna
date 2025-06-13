resource "aws_secretsmanager_secret" "pgadmin" {
  name        = "deuna-${var.environment}-pgadmin"
  description = "Credenciales pgadmin Aurora Postgres"
  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "pgadmin_secret" {
  secret_id     = aws_secretsmanager_secret.pgadmin.id
  secret_string = jsonencode({
    username = var.pgadmin_username
    password = var.pgadmin_password
  })
}