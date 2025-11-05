provider "aws" {}
resource "aws_s3_bucket" "name" {
    bucket = "pragnatejamanjunadha"
  }
  resource "aws_s3_object" "s3object" {
    bucket = aws_s3_bucket.name.bucket
    key = "pragna.zip"
    source = "../day-9-lambda/pragna.zip"
    etag   = filemd5("../day-9-lambda/pragna.zip")  # relative path from Terraform file
  
  }