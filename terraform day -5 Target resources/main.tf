
resource "aws_instance" "name" {
    ami = "ami-06d455b8b50b0de4d"
    instance_type = "t2.micro"
    availability_zone = "us-west-2a"
    tags = {
        Name = "test"
    }

}

resource "aws_s3_bucket" "name" {
    bucket = "ramumamathapanduteja12345"
  

}





# the name itself target means only targetted resource will  be created in above code only s3 will create
# command---> terraform plan -target=aws_s3_bucket.name --- not only s3 any resource
#             terraform apply -target=aws_s3_bucket.name --- not only s3 any resource


