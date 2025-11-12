variable "aws_region" {
  description = "The region in which to create the infrastructure"
  type        = string
  nullable    = false
  default     = "us-west-1"  #here we need to define either us-east-1 or us-west-2 if i give other region will get error 
  validation {
    condition = var.aws_region == "us-east-1" || var.aws_region == "us-west-2"
    error_message = "The variable 'aws_region' must be one of the following regions: us-west-2, us-east-1"
  }
 }

provider "aws" {
  region = "us-east-1"
  
   
 }

 resource "aws_s3_bucket" "name" {
    bucket = "pragnateja"
    
  
}  #after run this will get error like The variable 'aws_region' must be one of the following regions: us-west-2,│ us-east-1, so it will allow any one region defined above in conditin block



### Example-2
variable "create_bucket" {
  type    = bool
  default = false
}

resource "aws_s3_bucket" "example" {
  count  = var.create_bucket ? 1 : 0
  bucket = "sdfghjklllloiuytreqqcnm"
}

## Example-3
variable "ramu" {
  type    = string
  default = "test"
}

resource "aws_instance" "example" {
  count         = var.ramu == "prod" ? 3 : 1
  ami           = "ami-0cae6d6fe6048ca2c"
  instance_type = "t2.micro"

  tags = {
    Name = "example-${count.index}"
  }
}

# #In this case:
# #If var.environment == "prod" → count = 3
# #Else (like dev, qa, etc.) → count = 1
# #terraform apply -var="environment=dev"

# if you want to use bool then you need to remove string i.e. prod
    #--->true==>  3 instances
    #--->false==> 1 instance

# if you don't want to use bool then you need to change the default value
     #--->default=prod---> 3 instances
     #--->default=dev or test or something----> 1 instance    