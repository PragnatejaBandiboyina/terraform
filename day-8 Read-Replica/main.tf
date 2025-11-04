provider "aws" {
  
}
resource "aws_db_instance" "primary" {
  identifier             = "pragna-primary"
  db_name                = "pragnadb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = var.username
  password               = var.password
  skip_final_snapshot    = true
  deletion_protection    = false
  publicly_accessible    = false
  backup_retention_period = 7
  backup_window           = "04:00-04:30"
  

  # Networking
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "pragna-primary"
  }
}


#  Read Replica

resource "aws_db_instance" "replica" {
  identifier                = "pragna-replica"
  replicate_source_db       = aws_db_instance.primary.identifier
  instance_class            = "db.t3.micro"
  publicly_accessible       = false
  deletion_protection       = false
  skip_final_snapshot       = true
  availability_zone   = "us-west-2b" 

  depends_on = [aws_db_instance.primary]

  tags = {
    Name = "pragna-replica"
  }
}


#  Subnet Group

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}


#  Security Group

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}