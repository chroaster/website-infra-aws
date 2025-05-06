output "website_endpoint" {
  description = "The S3 website endpoint"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "website_domain" {
  description = "The S3 website domain"
  value       = aws_s3_bucket_website_configuration.website.website_domain
}

output "cloudfront_domain" {
  description = "The CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.website.domain_name
}

output "nameservers" {
  description = "The nameservers for the Route 53 zone"
  value       = aws_route53_zone.main.name_servers
}