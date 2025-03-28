## role for EKS control plane ##
resource "aws_iam_role" "profiseeEKS-cluster-role" {
name = "profisee-eks-cluster-role"
#allows the EKS service to assume this role to manage the cluster
assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    {
        Action = [
        "sts:AssumeRole",
        ]
        Effect = "Allow"
        Principal = {
        Service = "eks.amazonaws.com"
        }
    },
    ]
})
}

## Grants EKS cluster permissions to interact with other resources ##
resource "aws_iam_role_policy_attachment" "profiseeEKS_cluster_policy" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
role       = aws_iam_role.profiseeEKS-cluster-role.name
}

resource "aws_eks_cluster" "profiseeEKS-cluster" {
    name = "profiseeEKS"
    role_arn = aws_iam_role.profiseeEKS-cluster-role.arn
    vpc_config {
    endpoint_private_access = true
    endpoint_public_access = true
    subnet_ids = [
        aws_subnet.publicSubnetA.id,
        aws_subnet.publicSubnetB.id,
        aws_subnet.privateSubnetA.id,
        aws_subnet.privateSubnetB.id
    ]
    }
    version = "1.31"
    depends_on = [ aws_iam_role_policy_attachment.profiseeEKS_cluster_policy ]
}