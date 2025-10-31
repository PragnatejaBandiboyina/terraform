resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags ={
        Name = "vpc"
    
    }
  
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name= "public-subnet"
    }
  
}
resource "aws_subnet" "name1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2b"
    tags = {
      Name="private-subnet"
    }
  
}
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name= "IG"
    }
  
}
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name="route-table-pub"
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

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "name" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.name1.id
    tags = {
      Name="NGW"
    }
  
}

resource "aws_route_table" "name1" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name="route-table-private"
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.name.id
    }
  
}

resource "aws_route_table_association" "name1" {
    subnet_id = aws_subnet.name1.id
    route_table_id = aws_route_table.name1.id
  
}

resource "aws_security_group" "cust-sg" {
    name = "allow_tls"
    vpc_id = aws_vpc.name.id
    tags = {
      Name="cust-sg"
    }
    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/24" ]
  }
  
}

resource "aws_instance" "name" {
    ami = "ami-06d455b8b50b0de4d"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [aws_security_group.cust-sg.id]
    associate_public_ip_address = true
    tags = {
      Name="pub-server"
    }
  
}

resource "aws_instance" "name1" {
    ami="ami-06d455b8b50b0de4d"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name1.id
    vpc_security_group_ids = [ aws_security_group.cust-sg.id ]
    tags = {
      Name="pri-server"
    }
  
}