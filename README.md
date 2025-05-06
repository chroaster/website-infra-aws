# Static Website Infrastructure

This repository contains the Terraform infrastructure code for hosting a static website on AWS. The infrastructure is designed to serve a static website with high availability and performance.

## Infrastructure Components

The infrastructure includes:
- S3 bucket for static website hosting
- CloudFront distribution for content delivery
- Route 53 for DNS management
- ACM (AWS Certificate Manager) for SSL/TLS certificate
- IAM roles and policies for secure access

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (version 1.0.0 or later)
- A registered domain name

## Configuration

1. Create a `terraform.tfvars` file with your domain name:
```hcl
domain_name = "your-domain.com"
```

2. Initialize Terraform:
```bash
terraform init
```

3. Review the planned changes:
```bash
terraform plan
```

4. Apply the infrastructure:
```bash
terraform apply
```

## Important: Name Server Configuration

The operation will stall until this is completed because:

1. The ACM certificate validation requires DNS validation
2. The CloudFront distribution needs a valid SSL certificate
3. The Route 53 hosted zone needs to be authoritative for your domain

To complete the setup:
1. Get the name servers from the Route 53 hosted zone
2. Update your domain's name servers at your domain registrar with these values
3. Wait for DNS propagation (can take up to 48 hours, but usually much faster)

## Infrastructure Details

- **Region**: Primary region is ap-northeast-2 (Seoul), with CloudFront distribution in us-east-1
- **S3 Bucket**: Configured for static website hosting with public read access
- **CloudFront**: Set up with HTTPS enforcement and optimized caching
- **Route 53**: Manages DNS records and domain routing
- **SSL/TLS**: Automatic certificate provisioning and validation through ACM

## Security

- S3 bucket is configured with appropriate public access settings
- HTTPS is enforced through CloudFront
- IAM roles follow the principle of least privilege

## Maintenance

To update the infrastructure:
1. Make changes to the Terraform configuration
2. Run `terraform plan` to review changes
3. Apply changes with `terraform apply`

To destroy the infrastructure:
```bash
terraform destroy
```