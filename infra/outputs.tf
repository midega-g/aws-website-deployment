output "bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.website_distribution.id
}

output "cloudfront_distribution_domain" {
  value = aws_cloudfront_distribution.website_distribution.domain_name
}

# output "lambda_function_url" {
#   value = aws_lambda_function_url.contact_form_url.function_url
# }

# output "sns_topic_arn" {
#   value = aws_sns_topic.contact_form_notifications.arn
# }