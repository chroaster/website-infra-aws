variable "domain_name" {
  description = "The domain name for the static website"
  type        = string
}

variable "is_aws_registered" {
  description = "Whether the domain is registered on AWS Route 53"
  type        = bool
  default     = true
}
