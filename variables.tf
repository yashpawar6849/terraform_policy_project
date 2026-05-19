variable "aws_region" {
  description = "AWS region for resource provisioning."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "default_tags" {
  description = "Default tags applied to all resources."
  type        = map(string)
  default = {
    Owner       = "terraform-team"
    Project     = "policy-driven-infra"
    ManagedBy   = "Terraform"
  }
}

variable "website_index_document" {
  description = "The default root object served by CloudFront."
  type        = string
  default     = "index.html"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class for the distribution."
  type        = string
  default     = "PriceClass_100"
}
