
# ECR repositories

variable "ecr_default_retention_count" {
  description = "Number of images left in the ECR registry"
  default     = 5
}

resource "aws_ecr_repository" "ecr-repository" {
  name = "${var.project}-web"
  image_scanning_configuration {
    scan_on_push = true
  }
}

data "template_file" "ecr-lifecycle" {
  template = file("${path.module}/policies/ecr-lifecycle-policy.json")
  vars = {
    count = var.ecr_default_retention_count
  }
}

resource "aws_ecr_lifecycle_policy" "ecr-lifecycle" {
  repository = aws_ecr_repository.ecr-repository.name
  policy     = data.template_file.ecr-lifecycle.rendered
}
