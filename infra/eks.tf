locals {
  cluster_name = "${var.project}-eks-${terraform.workspace}"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# resource "aws_kms_key" "eks" {
#   description = "EKS Secret Encryption Key"
# }

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "14.0.0"

  cluster_version = "1.18"
  cluster_name    = local.cluster_name
  cluster_enabled_log_types = (
    terraform.workspace == "prod"
    ? ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    : []
  )

  kubeconfig_aws_authenticator_env_variables = {
    AWS_PROFILE = var.aws_profile
  }

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  # cluster_encryption_config = [
  #   {
  #     provider_key_arn = aws_kms_key.eks.arn
  #     resources        = ["secrets"]
  #   }
  # ]

  tags = {
    Project     = var.project
    Environment = terraform.workspace
  }

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 30
  }

  node_groups = {
    t2small = {
      instance_types   = ["t2.small"]
      min_capacity     = 1
      max_capacity     = 5
      desired_capacity = 1

      k8s_labels = {
        Project      = var.project
        Environment  = terraform.workspace
        NodeType     = "managed"
        InstanceType = "t2.small"
      }

      additional_tags = {
        Project     = var.project
        Environment = terraform.workspace
      }
    }
  }

  map_users                   = var.map_users
  workers_additional_policies = [aws_iam_policy.worker_log_policy.arn]
}

data "aws_iam_policy_document" "worker_log_policy" {
  statement {
    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:logs:${var.aws_region}:*:*",
    ]
  }
}

resource "aws_iam_policy" "worker_log_policy" {
  name        = "eks-worker-logs-${local.cluster_name}"
  description = "EKS worker node logs policy for cluster ${local.cluster_name}"
  policy      = data.aws_iam_policy_document.worker_log_policy.json
}

resource "aws_security_group" "worker_redis" {
  name_prefix = "${local.cluster_name}-redis"
  description = "Allow worker nodes to communicate with Redis."
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [module.eks.worker_security_group_id]
    description     = "Allow inbound traffic from EKS worker nodes."
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Redis outbound traffic."
  }

  tags = {
    Name        = "${local.cluster_name}-redis_sg"
    Project     = var.project
    Environment = terraform.workspace
    Cluster     = local.cluster_name
  }
}

resource "aws_security_group" "worker_postgres" {
  name_prefix = "${local.cluster_name}-postgres"
  description = "Allow worker nodes to communicate with Postgres."
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.eks.worker_security_group_id]
    description     = "Allow inbound traffic from EKS worker nodes."
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Postgres outbound traffic."
  }

  tags = {
    Name        = "${local.cluster_name}-postgres_sg"
    Project     = var.project
    Environment = terraform.workspace
    Cluster     = local.cluster_name
  }
}
