
# Providers

terraform {
  required_version = ">= 0.14.6"

  required_providers {
    aws      = ">= 3.27.0"
    random   = ">= 3.0"
    local    = ">= 2.0"
    null     = ">= 3.0"
    template = ">= 2.2"
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

provider "random" {}

provider "local" {}

provider "null" {}

provider "template" {}
