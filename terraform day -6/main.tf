resource "aws_instance" "name" {
    ami = "ami-0bdd88bd06d16ba03"
    instance_type = "t3.micro"
    tags = {
      Name= "instance"
    }
  
}

# terraform import --> we will get the control of resouces in the terraform , which are created  manually
# for example in the above mentioned resource instance i have created manuaaly but now accesing through terraform
# by using terraform import
#command ---> terraform import <resource name> <id>
# i.e for instance instance id ,, for s3 bucket name......
# after running this command state file will create accordingly we need to update our main.tf file