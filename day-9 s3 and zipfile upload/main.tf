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

  #after uploading zipfile to s3 we need to select upload from s3 in lambda function 
  #only after changing the python code in lambda 
  #init,plan,apply on both ends in s3 zipfile uploaded directory and lambda function directory