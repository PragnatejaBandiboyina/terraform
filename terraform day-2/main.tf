resource "aws_instance" "name" {
    ami = var.pragna
    instance_type = var.janu
    tags = {
      Name="pragna"
    }
  
}

resource "aws_instance" "name12" {
    ami = var.ami_id
    instance_type = var.janu
    tags = {
      Name="my-ec2-1"
    }
  
}
