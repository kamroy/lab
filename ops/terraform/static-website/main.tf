provider "aws" {
  region  = var.region
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "romeo-bucket"
  force_destroy = true
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3bucket" {
  bucket = aws_s3_bucket.s3bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3bucket" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3bucketacl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3bucket,
    aws_s3_bucket_public_access_block.s3bucket,
  ]

  bucket = aws_s3_bucket.s3bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.s3bucket.id

  index_document {
    suffix = "index.html"
  }
}
