
provider "aws" {}

terraform {
    backend "s3" {
        region = "us-east-1"
        encrypt = true
    }

    required_version = ">=  1.0.9"
}