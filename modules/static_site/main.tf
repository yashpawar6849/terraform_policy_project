locals {
  origin_id = "S3-${aws_s3_bucket.website.id}"
  frontend_files = {
    "index.html" = "index.html"
    "app.js"    = "app.js"
    "style.css" = "style.css"
  }
}

resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name
  acl    = "private"

  force_destroy = true

  tags = merge(var.default_tags, {
    Name        = "static-site-bucket"
    Environment = var.environment
  })
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for static website bucket"
}

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action   = ["s3:GetObject"]
        Resource = ["${aws_s3_bucket.website.arn}/*"]
      }
    ]
  })
}

resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = var.website_index_document

  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = local.origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = var.price_class

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_s3_bucket_object" "frontend_files" {
  for_each = local.frontend_files

  bucket = aws_s3_bucket.website.id
  key    = each.key
  content = file("${path.module}/../../frontend/${each.value}")
  content_type = lookup({
    "index.html" = "text/html",
    "app.js"    = "application/javascript",
    "style.css" = "text/css"
  }, each.key, "application/octet-stream")
}
