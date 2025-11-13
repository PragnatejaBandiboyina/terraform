resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_1_cidr
    availability_zone = var.availabilityzone1
  }
  resource "aws_subnet" "name1" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_2_cidr
    availability_zone = var.availabilityzone2
  }

output "subnet_1_id" {
  value = "${aws_subnet.name.id}"
}
output "subnet_2_id" {
  value = "${aws_subnet.name1.id}"
}