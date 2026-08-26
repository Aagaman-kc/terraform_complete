terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Upgraded to 5.0 for 2026 best practices
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # No keys here! Terraform reads them from your PowerShell env vars.

  # CRITICAL: These 3 lines tell Terraform NOT to validate against real AWS
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  # CRITICAL: These lines force Terraform to hit LocalStack instead of real AWS
  endpoints {
    s3        = "http://localhost:4566"
    dynamodb  = "http://localhost:4566"
    sts       = "http://localhost:4566"   # This is crucial for the STS error!
    iam       = "http://localhost:4566"
    route53   = "http://localhost:4566"
    rds       = "http://localhost:4566"
  }
}

# 1. S3 Bucket (Storage)
resource "aws_s3_bucket" "my_local_bucket" {
  bucket = "unique-bucket-name-2026-abc123" # Change this to something unique
}

# 2. DynamoDB Table (Database)
resource "aws_dynamodb_table" "my_local_table" {
  name         = "UserVisits"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

# 3. IAM User (just to practice creating one with Terraform)
resource "aws_iam_user" "app_user" {
  name = "app-service-user"
}