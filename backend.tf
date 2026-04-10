terraform {
  backend "s3" {
    bucket       = "threetier-terraform-state-bucket-tunex"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}


# Create the S3 bucket for remote state storage

resource "aws_s3_bucket" "threetier-terraform-state-bucket" {
  bucket = "threetier-terraform-state-bucket-tunex"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "threetier-terraform-state-bucket-tunex"
    Environment = "prod"
  }
}

# Enable S3 bucket versioning

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.threetier-terraform-state-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side S3 bucket encryption

resource "aws_kms_key" "ThreeTier_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.threetier-terraform-state-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.ThreeTier_key.id
      sse_algorithm     = "aws:kms"
    }
  }
}

# Block all public access to the state bucket

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.threetier-terraform-state-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

