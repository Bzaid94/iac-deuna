output "bucket_arn" {
  value       = aws_s3_bucket.secure.arn
  description = "Encrypted bucket ARN"
}