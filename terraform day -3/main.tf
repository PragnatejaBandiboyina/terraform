resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="my vpc"
    }
  }

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    availability_zone = "us-west-2a"
    cidr_block = "10.0.0.0/24"
    tags ={
        Name="my subnet"
    }
  
}

resource "aws_instance" "name" {
  ami = var.test
  instance_type = var.dev
  subnet_id = aws_subnet.name.id
  tags = {
    Name="my ec2"
  }
  
}

resource "aws_s3_bucket" "name" {
  bucket = "my-new-tf-backend-bucket"
  
}