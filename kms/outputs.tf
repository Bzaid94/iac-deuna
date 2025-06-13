output "key_arn" {
  value       = aws_kms_key.deuna.arn
  description = "ARN of the KMS key"
}