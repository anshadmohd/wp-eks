
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access  = true
  cluster_endpoint_public_access  = false

  cluster_addons = var.cluster_addons
  # {
  #   kube-proxy = {
  #     most_recent = true
  #   }
  #   vpc-cni = {
  #     most_recent = true
  #   }
  #   coredns = {
  #     most_recent = true
  #   }
  #   aws-ebs-csi-driver = {
  #     most_recent = true
  #   }
  # }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = concat(module.vpc.private_subnets,module.vpc.public_subnets)
  cluster_encryption_config = {}
  
  cluster_security_group_additional_rules = {
    ingress_bastion_sg = {
    description                = "Allow all traffic from bastion_sg"
    protocol                   = "tcp"
    from_port                  = 0
    to_port                    = 65535
    type                       = "ingress"
    source_security_group_id    = aws_security_group.bastion_sg.id
    }
  }


  eks_managed_node_groups = {
    basenodes = {
      name        = "basenodes"
      node_group_name = "basenodes"
      min_size     = 1
      max_size     = 1
      desired_size = 1
      disk_size    = 50

      ami_type     = "AL2_x86_64"

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"

      subnet_ids     =  module.vpc.private_subnets

      use_custom_launch_template  = false
      remote_access  = {
        ec2_ssh_key = "eks"
        source_security_group_ids = [aws_security_group.bastion_sg.id]
      }
    Tag = {
      name = "basenodes"
    }
   }
  }

  tags = {
    Environment = "demo"
    Terraform   = "true"
  }
}
