variable "aws_ec2_ami_id" {
  description = "ID for amazon machine image to use in EC2 instance"
  type        = string
  default     = "ami-403e2524"
}

variable "ssh_key_name" {
  description = "Name for generated key pair for ec2 instance"
  type        = string
  default     = "test-go-app-key"
}
