region = "us-east-1"
tags = {
  Environment = "production"
  Project     = "fastapi-project"
}
eks_cluster_role_name               = "fastapi-eks-cluster-role"
eks_nodegroup_role_name             = "fastapi-eks-nodegroup-role"
eks_nodegroup_instance_profile_name = "fastapi-eks-nodegroup-instance-profile"
project_name                        = "fastapi-project"
namespace                           = "fastapi-namespace"
ecr_pull_service_account_name       = "ecr-pull-sa"
loki_service_account_name           = "loki-sa"
bucket_name1                        = "fastapi-project-bucket-1"
bucket_name2                        = "fastapi-project-bucket-2"
bucket_name3                        = "fastapi-project-bucket-3"
cidr_block                          = "10.0.0.0/16"
vpc_name                            = "fastapi-vpc"
env                                 = "production"
subnet_cidr_block                   = "10.0.1.0/24"
subnet_cidr_block2                  = "10.0.2.0/24"
subnet_tags = {
  "kubernetes.io/role/elb" = "1"
}
private_subnet_cidr_block  = "10.0.3.0/24"
private_subnet_cidr_block2 = "10.0.4.0/24"
private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = "1"
}
availability_zone         = "us-east-1a"
availability_zone2        = "us-east-1b"
cluster_name              = "fastapi-eks-cluster"
node_group_desired_size   = 3
node_group_max_size       = 3
node_group_min_size       = 2
node_group_instance_types = ["t3.small"]
alb_namespace             = "kube-system"
alb_service_account_name  = "aws-load-balancer-controller"