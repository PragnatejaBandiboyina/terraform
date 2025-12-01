provider "aws" {
    region = "us-east-1"
  }
  resource "aws_instance" "name" {
    ami = "ami-0fa3fe0fa7920f68e"
    instance_type = "t2.micro"
    tags = {
      Name="pragna"
    }
    }
    resource "aws_vpc" "name" {
        cidr_block = "10.0.0.0/16"
        tags = {
          Name="my-vpc"
        }
      }
      resource "aws_subnet" "name" {
        vpc_id = aws_vpc.name.id
        cidr_block = "10.0.0.0/24"
        availability_zone = "us-east-1a"
        tags = {
          Name="subnet-public"
        }
        }
        resource "aws_internet_gateway" "name" {
            vpc_id = aws_vpc.name.id
            tags = {
              Name="igw"
            }
          }
          resource "aws_route_table" "name" {
            vpc_id = aws_vpc.name.id
            tags = {
              Name="rt"
            }
            route {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.name.id
            }
            
          }
          resource "aws_route_table_association" "name" {
            subnet_id = aws_subnet.name.id
            route_table_id = aws_route_table.name.id
            }
            resource "aws_security_group" "name" {
                vpc_id = aws_vpc.name.id
                name = "allow"
                tags = {
                  Name="my-sg"
                }
                ingress {
                    description = "HTTP"
                    from_port = 80
                    to_port = 80
                    protocol = "tcp"
                    cidr_blocks = [ "0.0.0.0/0" ]
                }
                ingress {
                    description = "HTTPS"
                    from_port = 443
                    to_port = 443
                    protocol = "tcp"
                    cidr_blocks = [ "0.0.0.0/0" ]
                }
                ingress {
                    description = "SSH"
                    from_port = 22
                    to_port = 22
                    protocol = "tcp"
                    cidr_blocks = [ "0.0.0.0/0" ]
                }
                egress {
                    from_port = 0
                    to_port = 0
                    protocol = "-1"
                    cidr_blocks = [ "0.0.0.0/0" ]
                }
              }