terraform {
  backend "s3" {
    bucket = "ramumamathapragnatejajanu"
    key    = "terraform day-3/terraform.tfstate"
    region = "us-west-2"
  }
}