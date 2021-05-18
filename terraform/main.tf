terraform {
  backend "s3" {
    bucket = "vivian-allen-concourse-tf-aws-1"
    key    = "concourse-tf-aws.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.40"
    }
  }

  required_version = ">= 0.15.3"
}

# NB all aws credentials got from concourse env - 'partial configuration'
provider "aws" {}

module "test_go_app" {
  source = "./modules/test_go_app"
}

output "test_go_app_elb_dns_name" {
  value = module.test_go_app.test_go_app_elb_dns_name
}
