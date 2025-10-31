resource "aws_instance" "name" {
    ami="ami-06d455b8b50b0de4d"
    instance_type = "t2.micro"
    tags = {
      Name = "pragna"
    }
    lifecycle {
      ignore_changes = [ tags ]
    }

}
# ignore changes here i mentioned tags to ignore that means if we change the name of instance in the remote 
# after running paln, apply ---> no changes i.e tags got ignored statefile will not override 