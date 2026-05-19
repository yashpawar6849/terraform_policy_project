package terraform.policy

# Deny S3 buckets that do not include the required environment tag.

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"
  not resource.change.after.tags.Environment
  msg = sprintf("S3 bucket %v is missing the Environment tag", [resource.address])
}

# Deny insecure bucket ACL values.

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"
  resource.change.after.acl != "private"
  msg = sprintf("S3 bucket %v must use private ACL", [resource.address])
}

# Enforce CloudFront minimum TLS protocol.

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_cloudfront_distribution"
  resource.change.after.viewer_certificate.minimum_protocol_version != "TLSv1.2_2021"
  msg = sprintf("CloudFront distribution %v must use TLSv1.2_2021 or newer", [resource.address])
}
