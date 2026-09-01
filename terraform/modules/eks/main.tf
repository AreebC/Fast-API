resource "aws_eks_cluster" "eks_cluster" {
    name = var.cluster_name
    role_arn = var.eks_cluster_role_arn
    vpc_config {
        subnet_ids = var.subnet_ids
    }
    tags = var.tags 
    enabled_cluster_log_types = [ 
        "api",
        "audit",
        "authenticator",
        "controllerManager",
        "scheduler"
     ]
}

resource "aws_eks_node_group" "eks_nodegroup" {
    cluster_name    = aws_eks_cluster.eks_cluster.name
    node_group_name = "${var.cluster_name}-node-group"
    node_role_arn   = var.eks_nodegroup_role_arn
    subnet_ids      = var.subnet_ids

    scaling_config {
        desired_size = var.node_group_desired_size
        max_size     = var.node_group_max_size
        min_size     = var.node_group_min_size
    }

    instance_types = var.node_group_instance_types

    tags = var.tags
}

resource "aws_security_group" "eks_cluster_sg" {
    name        = "${var.cluster_name}-eks-cluster-sg"
    description = "Security group for EKS cluster"
    vpc_id      = var.vpc_id

    ingress {
        description = "Allow all traffic from worker nodes"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = var.private_subnet_cidrs
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.cluster_name}-eks-cluster-sg"
    }
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  addon_name             = "vpc-cni"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "coredns" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  addon_name             = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  addon_name             = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
}