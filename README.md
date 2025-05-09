# Static Website Infrastructure

This repository contains the Terraform infrastructure code for hosting a static website on AWS. The infrastructure is designed to serve a static website with high availability and performance.

## Infrastructure Components

The infrastructure includes:
- S3 bucket for static website hosting with public read access
- CloudFront distribution for content delivery with HTTPS enforcement
- Route 53 for DNS management (supports both AWS-registered and third-party domains)
- ACM (AWS Certificate Manager) for SSL/TLS certificate
- IAM roles and policies for secure access
- Custom error page support
- IPv6 support
- Geo-restriction controls
- Optimized caching configuration

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (version 1.0.0 or later)
- A registered domain name (can be registered on AWS Route 53 or with a third-party registrar)

## Domain Registration Options

This infrastructure supports two domain registration scenarios:

### 1. AWS Route 53 Registered Domain
If your domain is registered through AWS Route 53:
- Set `is_aws_registered = true` in your configuration
- No additional DNS configuration is required
- Route 53 will automatically manage all DNS records

### 2. Third-Party Registered Domain
If your domain is registered with a third-party registrar (e.g., GoDaddy, Namecheap):
- Set `is_aws_registered = false` in your configuration
- You'll need to update your domain's name servers
- Once DNS has propagated, run the same `terraform apply` or `terraform apply "plan-name"`
- Follow the name server configuration steps below

## Configuration

1. Create a `terraform.tfvars` file with your configuration:
```hcl
domain_name = "your-domain.com"
is_aws_registered = true  # Set to false if using a third-party domain registrar
```

2. Initialize Terraform:
```bash
terraform init
```

3. Review the planned changes:
```bash
terraform plan --out=plan-name
```

4. Apply the infrastructure:
```bash
terraform apply "plan-name"
```

## Name Server Configuration (Third-Party Domains Only)

If you're using a third-party domain registrar, follow these steps:

1. After applying the infrastructure, note the name servers provided in the Terraform output
2. Log in to your domain registrar's control panel
3. Update your domain's name servers with the values from the Terraform output
4. Wait for DNS propagation (can take up to 48 hours, but usually much faster)

Note: If your domain is registered through AWS Route 53, you can skip these steps as the name servers will be configured automatically.

## Important: Name Server Configuration

For proper setup of your domain, you'll need to:

1. Configure DNS validation for the ACM certificate
2. Set up the CloudFront distribution with a valid SSL certificate
3. Ensure the Route 53 hosted zone is authoritative for your domain

To complete the setup:
1. Get the name servers from the Route 53 hosted zone (output will be provided)
2. Update your domain's name servers at your domain registrar with these values
3. Wait for DNS propagation (can take up to 48 hours, but usually much faster)

## Infrastructure Details

- **Region**: Primary region is ap-northeast-2 (Seoul), with CloudFront distribution in us-east-1
- **S3 Bucket**: 
  - Configured for static website hosting with public read access
  - Custom error page support
  - Bucket ownership controls
  - Public access block settings
- **CloudFront**: 
  - HTTPS enforcement
  - IPv6 support
  - Optimized caching (TTL: 1 hour default, 24 hours max)
  - Custom error page support
  - SNI-only SSL support
  - TLSv1.2_2021 minimum protocol version
- **Route 53**: 
  - Supports both AWS-registered and third-party domains
  - Automatic DNS record creation
  - Alias record for CloudFront distribution
- **SSL/TLS**: 
  - Automatic certificate provisioning and validation through ACM
  - DNS validation method
  - Certificate lifecycle management

## Security

- S3 bucket is configured with appropriate public access settings
- HTTPS is enforced through CloudFront
- IAM roles follow the principle of least privilege
- TLS 1.2 minimum protocol version
- SNI-only SSL support
- Custom error page handling
- Geo-restriction controls available

## Outputs

The infrastructure provides the following outputs:
- `website_endpoint`: The S3 website endpoint
- `website_domain`: The S3 website domain
- `cloudfront_domain`: The CloudFront distribution domain name
- `name_servers`: Name servers to configure at your domain registrar (only for third-party domains)

## Maintenance

To update the infrastructure:
1. Make changes to the Terraform configuration
2. Run `terraform plan` to review changes
3. Apply changes with `terraform apply`

To destroy the infrastructure:
```bash
terraform destroy
```

## IAM Permissions

The infrastructure requires the following IAM permissions:
- S3 bucket management
- Route 53 zone and record management
- ACM certificate management
- CloudFront distribution management
- IAM role and policy management

Detailed IAM policy is provided in the `iam` directory. Before applying the infrastructure, you must update the domain name in the IAM policy file:

1. Open `iam/Terraform-S3-StaticWebsite-Route53.json`
2. Replace `website.com` with your actual domain name in the S3 bucket ARN:
```json
"Resource": [
    "arn:aws:s3:::your-domain.com",
    "arn:aws:s3:::your-domain.com/*"
]
```
3. Use the policy for the AWS user account that Terraform will be using. This ensures that the IAM policy grants the correct permissions for your specific S3 bucket without requiring blanket permissions.