 resource "aws_s3_bucket" "name" {
    bucket = "pragnatejamanjunadha"
    }
 resource "aws_instance" "name" {
    ami = "ami-04f9aa2b7c7091927"
    instance_type = "t3.micro"
    provider = aws.oregon
  }

  # if you want to create resorces on different regions use provider alias