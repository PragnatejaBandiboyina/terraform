provider "aws" {
  region = "us-east-1"
}

# Create IAM Role (trusted by EC2)
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#  Attach AWS Managed Policy (EC2 ReadOnly)
resource "aws_iam_role_policy_attachment" "ec2_managed_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

#  Create IAM Instance Profile (needed to attach role to EC2)
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

#  Create EC2 Instance with IAM Role attached
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0cae6d6fe6048ca2c"   # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "EC2WithIAMRole"
  }
}
