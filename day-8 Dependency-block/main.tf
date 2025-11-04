provider "aws" {
  
}
resource "aws_instance" "name" {
    ami = var.ami
    instance_type = var.type
    tags = {
      Name="Pragnateja"
    }
    depends_on = [ aws_s3_bucket.name ]
  
}

resource "aws_s3_bucket" "name" {
    bucket = "pragnatejajahnaviramumamathabandiboyina"
  
}