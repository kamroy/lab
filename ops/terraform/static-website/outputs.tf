output s3_bucket_name {
  value       = aws_s3_bucket.s3bucket.id
  description = "name of s3bucket"
}

output s3_bucket_arn {
  value       = aws_s3_bucket.s3bucket.arn
}
