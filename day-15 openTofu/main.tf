resource "aws_instance" "name" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.pub-sub.id
    vpc_security_group_ids = [aws_security_group.name.id]
    associate_public_ip_address = true
    tags = {
      Name="my-ec2"
    }
  }
  resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="my-vpc"
    }
}
resource "aws_subnet" "pub-sub" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name="pub-subnet"
}
    }
   resource "aws_subnet" "pri-subnet" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name="pri-subnet"
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
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.name.id
        }
         }
         resource "aws_route_table_association" "name" {
            subnet_id = aws_subnet.pub-sub.id
            route_table_id = aws_route_table.name.id
           }
           resource "aws_security_group" "name" {
            vpc_id = aws_vpc.name.id
            name = "allow"
            tags = {
              Name="my-sg"
              }
             ingress {
                description = "ssh"
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
             }
             ingress {
                description = "http"
                from_port = 80
                to_port = 80
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