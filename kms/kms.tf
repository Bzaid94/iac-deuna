resource "aws_kms_key" "deuna" {
  description         = "Key for S3 & RDS"
  enable_key_rotation = true
  tags = {
    Environment = var.environment
  }
}