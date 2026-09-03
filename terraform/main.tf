module "s3" {
  source       = "./modules/s3"
  bucket_name1 = var.bucket_name1
  bucket_name2 = var.bucket_name2
  bucket_name3 = var.bucket_name3
}

module "vpc" {
  source                     = "./modules/vpc"
  cidr_block                 = var.cidr_block
  vpc_name                   = var.vpc_name
  env                        = var.env
  subnet_cidr_block          = var.subnet_cidr_block
  subnet_cidr_block2         = var.subnet_cidr_block2
  private_subnet_cidr_block  = var.private_subnet_cidr_block
  private_subnet_cidr_block2 = var.private_subnet_cidr_block2
  availability_zone          = var.availability_zone
  availability_zone2         = var.availability_zone2
  subnet_tags                = var.subnet_tags
  private_subnet_tags        = var.private_subnet_tags
}

module "iam-cluster" {
  source                              = "./modules/iam-cluster"
  tags                                = var.tags
  eks_cluster_role_name               = var.eks_cluster_role_name
  eks_nodegroup_role_name             = var.eks_nodegroup_role_name
  eks_nodegroup_instance_profile_name = var.eks_nodegroup_instance_profile_name
}

module "eks" {
  source                    = "./modules/eks"
  depends_on                = [module.vpc, module.iam-cluster]
  cluster_name              = var.cluster_name
  tags                      = var.tags
  eks_cluster_role_arn      = module.iam-cluster.eks_cluster_role_arn
  eks_nodegroup_role_arn    = module.iam-cluster.eks_nodegroup_role_arn
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = flatten([module.vpc.public_subnet_ids, module.vpc.private_subnet_ids])
  node_group_desired_size   = var.node_group_desired_size
  node_group_max_size       = var.node_group_max_size
  node_group_min_size       = var.node_group_min_size
  node_group_instance_types = var.node_group_instance_types
  private_subnet_cidrs      = module.vpc.private_subnet_cidrs
}

module "eks-oidc" {
  source       = "./modules/eks-oidc"
  eks_oidc_url = module.eks.oidc_issuer_url
  depends_on   = [module.eks]
}

module "ebs-csi-iam" {
  source = "./modules/ebs-csi-iam"

  eks_oidc_provider_arn = module.eks-oidc.oidc_provider_arn
  eks_oidc_hostpath     = module.eks-oidc.oidc_hostpath

  depends_on = [
    module.eks-oidc
  ]
}

module "eks-addons" {
  source = "./modules/eks-addons"

  cluster_name     = module.eks.cluster_name
  ebs_csi_role_arn = module.ebs-csi-iam.ebs_csi_role_arn

  depends_on = [
    module.eks,
    module.ebs-csi-iam
  ]
}

module "ecr-pull-iam" {
  source               = "./modules/ecr-pull-iam"
  project_name         = var.project_name
  eks_OIDC             = module.eks.oidc_issuer_url
  namespace            = var.namespace
  service_account_name = var.ecr_pull_service_account_name
}

module "loki-irsa" {
  source               = "./modules/loki-irsa"
  project_name         = var.project_name
  eks_OIDC             = module.eks-oidc.oidc_hostpath
  loki_namespace       = var.loki_namespace
  service_account_name = var.loki_service_account_name
  bucket_names         = [ 
    module.s3.bucket_name1,
    module.s3.bucket_name2,
    module.s3.bucket_name3
  ]
}

module "github-oidc" {
  source = "./modules/github-oidc"
}

module "alb" {
  source                = "./modules/alb"
  eks_OIDC              = module.eks.oidc_issuer_url
  namespace             = var.alb_namespace
  cluster_name          = var.cluster_name
  region                = var.region
  service_account_name  = var.alb_service_account_name
  eks_oidc_provider_arn = module.eks-oidc.oidc_provider_arn
  eks_oidc_hostpath     = module.eks-oidc.oidc_hostpath
  depends_on            = [module.eks, module.iam-cluster]
}

module "argocd" {
  source     = "./modules/argocd"
  depends_on = [module.eks, module.alb]
}

module "argocd-bootstrap" {
  source     = "./modules/argocd-bootstrap"
  depends_on = [module.eks, module.argocd]
}



