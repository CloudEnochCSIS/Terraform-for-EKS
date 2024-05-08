module "vpc" {
  source                = "../modules/vpc"
  region                = var.region
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
}

module "nat-gateway" {
  source              = "../modules/Nat-Gateway"
  public_subnet_1_id  = module.vpc.public_subnet_1_id
  public_subnet_2_id  = module.vpc.public_subnet_2_id
  vpc_id              = module.vpc.vpc_id
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
  internet_gateway_id = module.vpc.internet_gateway_id

}
module "IAM" {
  source       = "../modules/IAM"
  project_name = var.project_name
}

module "eks" {
  source               = "../modules/EKS"
  project_name         = var.project_name
  eks_cluster_role_arn = module.IAM.eks_cluster_role_arn
  private_subnet_1_id  = module.vpc.private_subnet_1_id
  private_subnet_2_id  = module.vpc.private_subnet_2_id
  public_subnet_1_id   = module.vpc.public_subnet_1_id
  public_subnet_2_id   = module.vpc.public_subnet_2_id
}

module "node_group" {
  source           = "../modules/Node-Group"
  eks_cluster_name = module.eks.eks_cluster_name
  node_group_arn   = module.IAM.node_group_role_arn
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id

}