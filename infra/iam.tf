resource "aws_iam_policy" "contact_form_sns_publish" {
  name = "ContactFormSNSPublish"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sns:Publish"
        Resource = aws_sns_topic.contact_form_notifications.arn
      }
    ]
  })
}

resource "aws_iam_role" "contact_form_lambda_role" {
  name = "contact-form-lambda-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.contact_form_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "contact_form_sns_publish" {
  role       = aws_iam_role.contact_form_lambda_role.name
  policy_arn = aws_iam_policy.contact_form_sns_publish.arn
}