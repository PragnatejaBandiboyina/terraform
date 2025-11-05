provider "aws" {
  region = "us-west-2"
}

# 1️⃣ Get existing VPC (by name tag)
data "aws_vpc" "myvpc" {
  filter {
    name   = "tag:Name"
    values = ["my-vpc"]
  }
}

# 2️⃣ Create a new subnet (subnet-3)
resource "aws_subnet" "subnet3" {
  vpc_id                  = data.aws_vpc.myvpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-3"
  }
}

# 3️⃣ Create an Internet Gateway (if not already there)
resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.myvpc.id

  tags = {
    Name = "my-vpc-igw"
  }
}

# 4️⃣ Create a route table for the subnet
resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# 5️⃣ Associate route table with subnet-3
resource "aws_route_table_association" "subnet3_assoc" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public_rt.id
}

# 6️⃣ Create EC2 instance in subnet-3
resource "aws_instance" "teja" {
  ami           = "ami-06d455b8b50b0de4d"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet3.id
  user_data     = file("pragna.sh")

  tags = {
    Name = "teja"
  }

  depends_on = [
    aws_subnet.subnet3,
    aws_route_table_association.subnet3_assoc
  ]
}
