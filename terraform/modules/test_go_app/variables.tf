variable "aws_ec2_ami_id" {
  description = "ID for amazon machine image to use in EC2 instance"
  type        = string
  default     = "ami-403e2524"
}

variable "aws_ec2_instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "TestGoAppServer"
}
