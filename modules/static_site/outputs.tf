output "bucket_id" {
  description = "The S3 bucket name for the static site."
  value       = aws_s3_bucket.website.id
}

output "cloudfront_domain" {
  description = "The CloudFront distribution domain name." 
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "website_url" {
  description = "The public website URL served through CloudFront."
  value       = "https://${aws_cloudfront_distribution.cdn.domain_name}"
}
