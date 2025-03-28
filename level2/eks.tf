module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "profiseeEKS"
  cluster_version = "1.31"

  vpc_id                   = module.level1.vpc_id
  subnet_ids               = module.level1.public_subnet_id
  control_plane_subnet_ids = module.level1.private_subnet_id

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    instance_types = ["t2.micro"]
    vpc_security_groups_id = [ module.level1.security_group ]

  }

  eks_managed_node_groups = {
    node_group = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.micro"]
      min_size     = 2
      max_size     = 4
      desired_size = 2
    }
  }

  tags = {
    Name = "profisee"
  }
}