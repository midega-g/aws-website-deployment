resource "aws_lambda_function" "contact_form_function" {
  filename         = "contact_form_function.zip"
  function_name    = "contact-form-function"
  role            = aws_iam_role.contact_form_lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.13"
  
  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.contact_form_notifications.arn
      WEBSITE_URL   = var.website_url
    }
  }
}

resource "aws_lambda_function_url" "contact_form_url" {
  function_name      = aws_lambda_function.contact_form_function.function_name
  authorization_type = "NONE"
  
  cors {
    allow_credentials = false
    allow_origins     = [var.website_url]
    allow_methods     = ["POST"]
    allow_headers     = ["Content-Type"]
    max_age          = 86400
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "contact_form_function.zip"
  source {
    content = templatefile("${path.module}/lambda_function.py", {
      sns_topic_arn = aws_sns_topic.contact_form_notifications.arn
    })
    filename = "lambda_function.py"
  }
}