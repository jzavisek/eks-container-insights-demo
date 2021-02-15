# AWS EKS

## Commands

```zsh
terraform init
terraform workspace new dev
terraform workspace list
terraform workspace select dev
terraform apply

export AWS_PROFILE=playground
export KUBECONFIG=/Volumes/STRV/Dev/_Meetings/eks/infra/kubeconfig_jz-demo-eks-dev
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
```

## Diagrams

* [Architecture Diagram](https://d1.awsstatic.com/Getting%20Started/eks-project/EKS-demo-app.e7ce7b188f2662b8573b5881a6b843e09caf729a.png)

## Terraform modules

* [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
* [EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)

## Terraform providers

* [Local](https://registry.terraform.io/providers/hashicorp/local/latest)
* [Null](https://registry.terraform.io/providers/hashicorp/null/latest)

## Resources

* [Architecture](https://aws.amazon.com/getting-started/hands-on/deploy-kubernetes-app-amazon-eks/)
* [Terraform EKS tutorial](https://learn.hashicorp.com/tutorials/terraform/eks)
* [AWS EKS Networking](https://docs.aws.amazon.com/eks/latest/userguide/create-public-private-vpc.html)
* [Nginx Ingress](https://kubernetes.github.io/ingress-nginx/)
