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

module "test_app_server" {
    source = "modules/test_app_server"
}
