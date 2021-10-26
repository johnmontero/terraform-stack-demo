resource "aws_s3_bucket" "this" {
    bucket = var.bucket_name
    acl    = var.bucket_acl

    tags = {
        Project     = var.project
        Environment = var.environment
    }
}