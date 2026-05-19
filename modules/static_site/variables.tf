variable "bucket_name" {
  description = "Unique name for the S3 website bucket."
  type        = string
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
}

variable "default_tags" {
  description = "Default tags applied to all resources."
  type        = map(string)
}

variable "website_index_document" {
  description = "Index document served by CloudFront."
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "CloudFront price class for the website distribution."
  type        = string
  default     = "PriceClass_100"
}
