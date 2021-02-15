
## Things to go through

* AWS deployment options
* Architecture
* VPC creating
* EKS cluster creating
* ECR
* Docker image + push
* Ingress controller
  * NLB = L4
  * ELB = L7, terminates SSL
  * `proxy-real-ip-cidr: XXX.XXX.XXX/XX` -> `proxy-real-ip-cidr: 10.0.0.0/16`
  * comment `service.beta.kubernetes.io/aws-load-balancer-ssl-cert:`
* Route 53 Alias
* fluentd
