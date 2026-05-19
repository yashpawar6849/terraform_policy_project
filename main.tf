terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

module "static_site" {
  source      = "./modules/static_site"
  bucket_name = "tf-policy-site-${var.environment}-${random_id.bucket_id.hex}"
  environment = var.environment
  default_tags = var.default_tags
  website_index_document = var.website_index_document
  price_class = var.cloudfront_price_class
}
