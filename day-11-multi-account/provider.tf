provider "aws" {
    region = "us-east-1"

  
}
provider "aws" {
    region = "us-west-2"
    alias = "oregon"
    profile = "pragna"
  
}
# if you want to create resources on different accounts use profile
# create user and give permissions