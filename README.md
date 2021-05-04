# AWS EKS

## Commands

### 1. Create a cluster
```zsh
cd ./infra
terraform init
terraform workspace new dev
terraform workspace list
terraform workspace select dev
terraform apply
```

### 2. Configure kubectl

```zsh
export AWS_PROFILE=playground
export KUBECONFIG=/path-to-project/infra/kubeconfig_jz-cwi-demo
aws eks --region eu-central-1 update-kubeconfig --name jz-cwi-demo-eks-dev
```

### 3. Build app Docker image (optional)

* Update ECR registry URL in the `Makefile`
* Run:

```zsh
cd ./app
make docker/image/build
make docker/image/push
```

### 4. Deploy nginx ingress controller and app (optional)

```zsh
cd ./k8s
make apply-nginx
make apply-namespaces
make apply-web
```

### 5. Deploy container insights

* Update `eks.amazonaws.com/role-arn` in `service-account.yaml` (run `terraform output` to get it)
* Run:

```zsh
cd ./k8s
make apply-dev-container-insights
```

## Concepts

* [Architecture](https://aws.amazon.com/getting-started/hands-on/deploy-kubernetes-app-amazon-eks/)
* [Terraform EKS tutorial](https://learn.hashicorp.com/tutorials/terraform/eks)
* [AWS EKS Networking](https://docs.aws.amazon.com/eks/latest/userguide/create-public-private-vpc.html)

## Diagrams

* [Architecture Diagram](https://d1.awsstatic.com/Getting%20Started/eks-project/EKS-demo-app.e7ce7b188f2662b8573b5881a6b843e09caf729a.png)

## Terraform modules

* [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
* [EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
  * [Variables](https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/variables.tf)

## Terraform providers

* [Local](https://registry.terraform.io/providers/hashicorp/local/latest)
* [Null](https://registry.terraform.io/providers/hashicorp/null/latest)

## Nginx ingress

* [Nginx Ingress](https://kubernetes.github.io/ingress-nginx/)
* [Deployment](https://kubernetes.github.io/ingress-nginx/deploy/)

