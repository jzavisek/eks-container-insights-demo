output "irsa_cloudwatch_agent_arn" {
  description = "CloudWatch agent IAM role ARN"
  value       = aws_iam_role.cloudwatch_agent_irsa.arn
}

output "oidc_url" {
  description = "OIDC URL"
  value       = aws_iam_openid_connect_provider.cluster.url
}
