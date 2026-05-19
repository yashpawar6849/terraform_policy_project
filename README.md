# Terraform Policy Project

Terraform project that deploys a static frontend website to AWS.

## What is included

- `main.tf` - Root module provisioning the static site module and random bucket suffix.
- `variables.tf` - AWS region, environment, CloudFront defaults, and resource tags.
- `outputs.tf` - CloudFront domain and website URL outputs.
- `modules/static_site/` - Reusable site module with secure S3 bucket, CloudFront distribution, and frontend asset deployment.
- `frontend/` - Simple static website assets deployed to the S3 bucket.
- `policies/terraform_policy.rego` - Example policy rules that enforce tagging and secure distribution settings.

## What this project does

- provisions a private S3 bucket for frontend assets
- creates a CloudFront distribution to serve the site securely
- uploads static frontend files from the `frontend/` directory
- includes rudimentary policy validation for infrastructure settings

## How to use

1. Change directory:
   ```bash
   cd D:\terraform-policy-project
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Create a plan:
   ```bash
   terraform plan -out=tfplan
   ```
4. Apply the deployment:
   ```bash
   terraform apply tfplan
   ```
5. After apply, the website URL will appear in the output as `site_url`.

## Frontend workflow

- Edit files in `frontend/index.html`, `frontend/app.js`, or `frontend/style.css`
- Run `terraform apply` again to update the deployed assets

## Notes

This project is still infrastructure-focused, but it now includes a frontend deployment path instead of only raw cloud resources.
