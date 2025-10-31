terraform {
  backend "s3" {
    bucket = "my-new-tf-backend-bucket"
    key    = "terraform day-3/terraform.tfstate"
    region = "us-west-2"
  }
}