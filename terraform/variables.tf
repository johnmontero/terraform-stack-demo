variable "project" {
    type        = string
    default     = ""
}

variable "environment" {
    type        = string
    default     = ""
}

variable "region" {
    type        = string
    default     = ""
    description = "If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee."
    }

variable "bucket_name" {
    type        = string
    description = "Bucket name"
}

variable "bucket_acl" {
    type        = string
    default     = "private"
    description = "Bucket acl"
}