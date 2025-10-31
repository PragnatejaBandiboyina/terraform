resource "aws_instance" "name" {
    ami = "ami-06d455b8b50b0de4d55"
    instance_type = "t2.micro"
    tags = {
      Name = "ec2"
    }

    lifecycle {
      create_before_destroy = true
    }

# by using this rule the instance will be created before destroying 
# which helps in real time if we created any wrong instance with wrong ami id so, the instance first will create ,
# while creating we get error but our previous instance will not destrory as we used the above rule
  
}