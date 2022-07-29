module "vpc" {
  source               = "./terraform-modules/vpc"
  project              = var.project
  region               = var.region
  tags                 = var.tags
  vpc_cidr             = var.vpc_cidr
  az1                  = var.az1
  az2                  = var.az2
  discriminat          = var.discriminat
  subnet_dmz_cidr_az1  = var.subnet_dmz_cidr_az1
  subnet_dmz_cidr_az2  = var.subnet_dmz_cidr_az2
  subnet_priv_cidr_az1 = var.subnet_priv_cidr_az1
  subnet_priv_cidr_az2 = var.subnet_priv_cidr_az2
  discriminat_az1_eni  = var.discriminat ? module.discriminat[0].target_network_interfaces[var.az1] : ""
  discriminat_az2_eni  = var.discriminat ? module.discriminat[0].target_network_interfaces[var.az2] : ""
}

module "ec2" {
  source             = "./terraform-modules/ec2"
  project            = var.project
  region             = var.region
  tags               = var.tags
  image              = var.image
  instance_type      = var.instance_type
  vpc_id             = module.vpc.vpc_id
  subnet_dmz_az1_id  = module.vpc.subnet_dmz_az1_id
  subnet_priv_az1_id = module.vpc.subnet_priv_az1_id
  subnet_priv_az2_id = module.vpc.subnet_priv_az2_id
  compute_az1_ip     = var.compute_az1_ip
  compute_az2_ip     = var.compute_az2_ip
  elastic_ips        = [module.vpc.eip_az1_ip, module.vpc.eip_az2_ip]
  log_bucket         = var.log_bucket
}

module "discriminat" {
  count          = var.discriminat == true ? 1 : 0
  source         = "ChaserSystems/discriminat-eni/aws"
  version        = "2.4.0"
  public_subnets = [module.vpc.subnet_dmz_az1_id, module.vpc.subnet_dmz_az2_id]
  tags           = var.tags
}