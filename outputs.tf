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

output "name_servers" {
  description = "Name servers to configure at your domain registrar"
  value       = var.is_aws_registered ? null : aws_route53_zone.main[0].name_servers
}
