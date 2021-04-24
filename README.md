# AWS Terraform modules

- Initialize your **provider.tf** before using this module.

## Following list has the names of hand-crafted modules that are ready to use or in-development.

- Cognito
- VPC
- EKS (Elastic Kubernetes Service)
- Istio [Service Mesh] 
  - Sample BookInfo Application
  - Prometheus and Grafana


## Providers [provider.tf]

```
provider "aws" {
  access_key = "<Access Key>"
  secret_key = "<Secret Key>"
  region = "ap-southeast-1"
}

provider "kubernetes" {
  config_path    = "kubeconfig"
  config_context = "<ContextName>"
}

provider "helm" {
  kubernetes {
    config_path = "kubeconfig"
  }
}
```

## Main [main.tf]

```
module "eks" {
  source       = "git::https://github.com/rajat965ng/aws_terraform_modules.git//eks"
  cluster-name = "maroon"
  aws_region   = "ap-southeast-1"
}


module "service-mesh" {
  source            = "git::https://github.com/rajat965ng/aws_terraform_modules.git//service-mesh"
  init_sample_app   = true
  enable_monitoring = true
}
```