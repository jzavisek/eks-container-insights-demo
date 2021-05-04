# Creates IAM Role for CloudWatch monitoring agent. IAM role can be attached to the K8s
# ServiceAccount and used by agent's DaemonSet.
# See: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-prerequisites.html

variable "serviceaccount" {
  description = "The name of kubernetes service account"
  type        = string
  default     = "cloudwatch-agent"
}

locals {
  oidc_fully_qualified_subjects = "system:serviceaccount:amazon-cloudwatch:${var.serviceaccount}"
}

# Create IAM role for K8s ServiceAccount attached to the CloudWatch Agent
# https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html

resource "aws_iam_role" "cloudwatch_agent_irsa" {
  name        = "${local.cluster_name}-cloudwatch-agent"
  description = "CloudWatch agent policy for cluster ${local.cluster_name}"
  path        = "/"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.cluster.arn
      }
      Condition = {
        StringEquals = {
          "${aws_iam_openid_connect_provider.cluster.url}:sub" = local.oidc_fully_qualified_subjects
        }
      }
    }]
    Version = "2012-10-17"
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]

  tags = {
    part        = "container-insights"
    environment = terraform.workspace
  }
}
