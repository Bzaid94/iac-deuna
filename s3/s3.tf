resource "random_id" "suffix" { byte_length = 3 }

resource "aws_s3_bucket" "secure" {
  bucket = "deuna-secure-${var.environment}-${random_id.suffix.hex}"
  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.secure.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_arn
    }
  }
}