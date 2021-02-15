
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


## Images
* https://www.instana.com/media/intro-to-fargate-logos-e1518618460317-1.png
* https://miro.medium.com/max/360/0*uGnkedWzlM-J1bYC
* https://miro.medium.com/max/360/1*qg4GEY91S1IHZ1nXfPCVSg.png
* https://res.cloudinary.com/practicaldev/image/fetch/s--dq3ooeUj--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://thepracticaldev.s3.amazonaws.com/i/lk4zkkbto2hzcxmt6x4g.png
* https://miro.medium.com/max/700/1*Tv6O3_ZEH6lukEIiLrdMsQ.png