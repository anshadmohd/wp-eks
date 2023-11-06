module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  create_igw         = var.create_igw
  # enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "production"
  }
}

#bastion SG for ssh access for eks-managed-nodes

resource "aws_security_group" "bastion_sg" {
  name        = var.bastion_sg_name
  vpc_id      = module.vpc.vpc_id

  // Define inbound rule for SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Define outbound rule to allow all traffic to go anywhere
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
