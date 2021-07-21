resource "aws_s3_bucket" "bucket" {
  bucket = var.tag_bucket_name
  acl    = "private"

  tags = {
    Name        = "Test"
    Environment = var.tag_bucket_environment
  }
  #Enable testing
  versioning {
    enabled = true
  }
}

#Upload objects to bucket

resource "aws_s3_bucket_object" "object1" {
  for_each = fileset("files/", "*")
  bucket   = aws_s3_bucket.bucket.id
  key      = each.value
  source   = "files/${each.value}"
  etag     = filemd5("files/${each.value}")
}

output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ]
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "8.8.8.8/32"
          }
        }
      },
    ]
  })
}
