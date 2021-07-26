resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  acl          = "public-read"
  content_type = "text/html"

  source = "${var.base_path}/index.html"
  etag   = filemd5("${var.base_path}/index.html")
}

resource "aws_s3_bucket_object" "error" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "404.html"
  acl          = "public-read"
  content_type = "text/html"

  source = "${var.base_path}/404.html"
  etag   = filemd5("${var.base_path}/404.html")
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ]
      },
    ]
  })
}
