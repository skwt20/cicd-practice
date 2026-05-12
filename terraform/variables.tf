variable "aws_region" {
  description = "AWS リージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "bucket_name" {
  description = "S3 バケット名（グローバルで一意である必要があります）"
  type        = string
}
