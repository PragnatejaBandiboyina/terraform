provider "aws" {
  
}
data "aws_vpc" "name" {
    filter {
      name = "tag:Name"
      values = [ "my-vpc" ]
    }
  }
data "aws_subnet" "name" {
    filter {
      name = "tag:Name"
      values = [ "subnet-1" ]
    }
  }
resource "aws_instance" "name" {
    ami =  var.ami
    instance_type = var.type
    subnet_id = data.aws_subnet.name.id
    tags = {
      Name="ec2"
    }
    }