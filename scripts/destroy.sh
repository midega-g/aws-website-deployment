#!/bin/bash

# Create S3 bucket using Terraform
pushd infra
    terraform init
    terraform destroy
popd