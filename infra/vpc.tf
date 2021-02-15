# Prepare VPC for EKS master nodes and worker nodes

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

data "aws_availability_zones" "available" {
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.70.0"

  name = "${var.project}-${terraform.workspace}"
  cidr = "10.0.0.0/16"

  azs                 = data.aws_availability_zones.available.names
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  database_subnets    = ["10.0.51.0/24", "10.0.52.0/24", "10.0.53.0/24"]
  elasticache_subnets = ["10.0.61.0/24", "10.0.62.0/24", "10.0.63.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # Shared NAT gateway (it would be better to have NAT per AZ but it can be quite expensive)
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  # Endpoint to AWS S3
  enable_s3_endpoint = true

  # Endpoint to AWS ECR
  enable_ecr_api_endpoint             = true
  ecr_api_endpoint_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Environment = terraform.workspace
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "true"
  }
}
