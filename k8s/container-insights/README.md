# Container Insights

## Resources to read

- <https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-EKS.html>
- <https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-EKS-quickstart.html>

## Prerequisites

* OIDC provider configured for the cluster - <https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html>
* IAM for ServiceAccount role created with CloudWatchAgentServerPolicy attached - <https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html>

## How to create FluentBit & CloudWatch Agent configs

These steps basically follow process described in the links above.

1. Run the command below, replace ClusterName and LogRegion with correct values:

```
ClusterName='jz-cwi-demo-eks-dev'
LogRegion='eu-central-1'
FluentBitHttpPort='2020'
FluentBitReadFromHead='Off'
[[ ${FluentBitReadFromHead} = 'On' ]] && FluentBitReadFromTail='Off'|| FluentBitReadFromTail='On'
[[ -z ${FluentBitHttpPort} ]] && FluentBitHttpServer='Off' || FluentBitHttpServer='On'
curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluent-bit-quickstart.yaml | sed 's/{{cluster_name}}/'${ClusterName}'/;s/{{region_name}}/'${LogRegion}'/;s/{{http_server_toggle}}/"'${FluentBitHttpServer}'"/;s/{{http_server_port}}/"'${FluentBitHttpPort}'"/;s/{{read_from_head}}/"'${FluentBitReadFromHead}'"/;s/{{read_from_tail}}/"'${FluentBitReadFromTail}'"/' > container-insights.yaml
```

2. This will create `container-insights.yaml`
3. Extract `cwagentconfig` and `fluent-bit-cluster-info` to kustomization overlay (so that we can update values per different environments)
4. Extract `cloudwatch-agent` config and add annotation with ARN of IAM role that gives agent permissions to write logs (OIDC provider needs to be configured first, <https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html>)
