# Frontend Launch Template
resource "aws_launch_template" "frontend" {
  name          = "frontend-terraform"
  description   = "Frontend server launch template"
  image_id      = "ami-0157af9aea2eef346"  # Using your provided AMI ID
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
  key_name      = "pragnamanju"
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-terraform"
    }
  }
}

# Backend Launch Template
resource "aws_launch_template" "backend" {
  name          = "backend-terraform"
  description   = "Backend server launch template"
  image_id      = "ami-0157af9aea2eef346"  # Using the same AMI ID
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  key_name      = "pragnamanju"
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-terraform"
    }
  }
}
