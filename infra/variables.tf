variable "region" {
  type        = string
  description = "the region to deploy resources to"
  default     = "us-east-1"
}

variable "default_tags" {
  type        = map(string)
  description = "Map of default tags to apply to resources"
  default = {
    "project" = "aws-website-deployment-challenge"
  }
}

variable "notification_email" {
  type        = string
  description = "Email address to receive contact form notifications"
}

variable "website_url" {
  type        = string
  description = "Website URL for CORS configuration"
}