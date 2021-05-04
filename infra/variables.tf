variable "aws_profile" {
  default = "playground"
}

variable "aws_region" {
  default = "eu-central-1"
}

variable "project" {
  default = "jz-cwi-demo"
  type    = string
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::805382315593:user/josef-zavisek-service-account"
      username = "josefzavisek"
      groups   = ["system:masters"]
    }
  ]
}
