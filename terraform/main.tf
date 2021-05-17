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

resource "aws_instance" "test_app_server" {
  ami           = var.aws_ec2_ami_id
  instance_type = "t2.micro"

  tags = {
    Name = var.aws_ec2_instance_name
  }
}
