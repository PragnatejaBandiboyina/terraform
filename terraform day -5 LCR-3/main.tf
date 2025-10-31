resource "aws_instance" "name" {
    ami = "ami-06d455b8b50b0de4d"
    instance_type = "t2.micro"
    tags = {
      Name = "server"
    }

    
     lifecycle {
       prevent_destroy = true
    
  
}
}

# the name itself prevent destroy --> which prevents the destroty of resources 
# in real time if we destory any resources by mistake this rule will helpful