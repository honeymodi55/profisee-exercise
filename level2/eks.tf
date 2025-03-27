/*module "eks" {
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
    vpc_security_groups_id = 
  }

  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]

      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}*/