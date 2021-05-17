resource "aws_instance" "test_app_server" {
  ami           = var.aws_ec2_ami_id
  instance_type = "t2.micro"

  tags = {
    Name = var.aws_ec2_instance_name
  }
}
