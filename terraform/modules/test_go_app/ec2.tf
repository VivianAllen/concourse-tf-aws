data "aws_availability_zones" "go_app_az" {
  state = "available"
}

# NB egress defaults to ALLOW ALL
resource "aws_security_group" "go_app_asg" {
  name = "go-api-instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "test_go_app" {
  name          = "test_go_app_lc"
  key_name      = var.aws_ec2_instance_name
  image_id      = var.aws_ec2_ami_id
  instance_type = "t2.micro"

  security_groups = [aws_security_group.go_app_asg.id]

  user_data = file("${path.module}/bootstrap.sh")

  lifecycle {
    create_before_destroy = true
  }
}
