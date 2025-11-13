module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.cidr
  subnet_1_cidr     = var.subnet-1
  subnet_2_cidr     = var.subnet-2
  availabilityzone1 =  var.az1
  availabilityzone2 =  var.az2
}
module "rds" {
    source = "./modules/rds"
    subnet_1_id = module.vpc.subnet_1_id
    subnet_2_id = module.vpc.subnet_2_id
    instance_class = var.dbinstance_class
    db_name = var.dbname
    db_user = var.dbuser
    identifier = var.identifier1
  }