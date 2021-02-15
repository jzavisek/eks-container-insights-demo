
# Get availability zones in the current region
data "aws_availability_zones" "available" {}

# Get region configured in the provider
data "aws_region" "current" {}

# Get account ID, user ID and ARN where terraform is authorized
data "aws_caller_identity" "current" {}
