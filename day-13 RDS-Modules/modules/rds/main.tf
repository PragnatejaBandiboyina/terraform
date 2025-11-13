resource "aws_db_subnet_group" "name" {
    name = "subnet_group"
    subnet_ids = [ var.subnet_1_id,var.subnet_2_id ]
  }
  resource "aws_db_instance" "name" {
    allocated_storage = 10
    engine = "mysql"
    engine_version = "8.0"
    instance_class = var.instance_class
    db_name = var.db_name
    username = var.db_user
    identifier = var.identifier
    db_subnet_group_name = aws_db_subnet_group.name.id
    manage_master_user_password = true
    skip_final_snapshot = true

    
  }