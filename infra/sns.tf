resource "aws_sns_topic" "contact_form_notifications" {
  name = "contact-form-notifications"
}

resource "aws_sns_topic_subscription" "email_notification" {
  topic_arn = aws_sns_topic.contact_form_notifications.arn
  protocol  = "email"
  endpoint  = var.notification_email
}