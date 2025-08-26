resource "aws_s3_bucket" "website_bucket" {
  bucket        = "midega-website-challenge-bucket"
  force_destroy = true

  tags = {
    Name        = "${var.default_tags.project}-s3"
    Environment = "Dev"
  }
}