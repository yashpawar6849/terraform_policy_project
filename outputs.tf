output "site_bucket" {
  description = "The S3 bucket name used by the static website."
  value       = module.static_site.bucket_id
}

output "cdn_domain" {
  description = "The CloudFront distribution domain name."
  value       = module.static_site.cloudfront_domain
}

output "site_url" {
  description = "The public URL for the static frontend served by CloudFront."
  value       = module.static_site.website_url
}
