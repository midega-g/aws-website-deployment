#!/bin/bash

# Create S3 bucket using Terraform
pushd infra
    terraform init
    terraform apply -auto-approve

    # Get bucket name from terraform output
    BUCKET_NAME=$(terraform output -raw bucket_name)
    CLOUDFRONT_DISTRIBUTION_ID=$(terraform output -raw cloudfront_distribution_id)
    CLOUDFRONT_DISTRIBUTION_DOMAIN=$(terraform output -raw cloudfront_distribution_domain)
popd

echo "Uploading files to S3 bucket: $BUCKET_NAME"

# Upload images folder to S3 bucket
aws s3 cp images/ s3://$BUCKET_NAME/images/ --recursive

# Upload website files to S3 bucket
aws s3 cp index.html s3://$BUCKET_NAME/
aws s3 cp style.css s3://$BUCKET_NAME/
aws s3 cp script.js s3://$BUCKET_NAME/


aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DISTRIBUTION_ID --paths "/*"

echo https://$CLOUDFRONT_DISTRIBUTION_DOMAIN