data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source            = "./modules/vpc"
  project_name      = var.project_name
  environment       = var.environment
  availability_zone = data.aws_availability_zones.available.names
  public_cidr       = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidr      = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  environment  = var.environment
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  project_name   = var.project_name
  environment    = var.environment
  security_group = [module.security_group.public_sg_id]
  subnets        = module.vpc.public_subnet_ids
  bucket_name    = var.bucket_name
}

module "asg" {
  source             = "./modules/asg"
  project_name       = var.project_name
  environment        = var.environment
  user_data          = "${path.module}/user_data.sh"
  target_group_arns  = [module.alb.target_arn]
  subnets            = module.vpc.private_subnet_ids
  security_group_ids = [module.security_group.private_sg_id]
  iam_instance_profile = module.iam.instance_profile_name
}

module "rds" {
  source                    = "./modules/rds"
  project_name              = var.project_name
  db_name                   = "twotierdb"
  engine                    = "mysql"
  instance_class            = var.instance_class
  subnet_ids                = module.vpc.private_subnet_ids
  db_username               = var.db_username
  db_password               = var.db_password
  final_snapshot_identifier = var.final_snapshot_identifier
  security_group_ids        = [module.security_group.rds_sg_id]
}