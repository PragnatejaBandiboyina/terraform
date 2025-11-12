provider "aws" {}
resource "aws_instance" "name" {
    ami="ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"
    count = 2
    tags={
        Name="pragna"    #----> this adds same name to both instances
    }
    
# tags = {
#        Name = "pragna-${count.index}"  # --> this add indexes to the instances
#                                        # --> like pragna-0 pragna-1 .....
#     }
 }

 
# variable "teja" {
#     type = list(string)
#   default = ["pragna","ramu"]
  
# }
# resource "aws_instance" "name" {
#     ami = "ami-0cae6d6fe6048ca2c"
#     instance_type = "t2.micro"
#     count = length(var.teja)
#     tags = {
#       Name = var.teja[count.index]
#     }
#    }

  # the drawback of using count is if you want to destroy any resource 
  # the desired one will not destroyed rather it gets renamed
  # because count follows index
  #  [pragna,janu,teja][0]--pragna,[1]--janu,[2]--teja
  #  here if you want to delete janu --it will not delete,,it deletes pragna and replaces janu as pragna