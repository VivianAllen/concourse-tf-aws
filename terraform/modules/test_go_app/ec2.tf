data "aws_availability_zones" "test_go_app" {
  state = "available"
}

# NB egress defaults to ALLOW ALL
resource "aws_security_group" "test_go_app" {
  name = "test-go-app-asecg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "test_go_app_elb" {
  name = "test-go-app-elb-asecg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "test_go_app" {
  name          = "test-go-app-lc"
  image_id      = var.aws_ec2_ami_id
  instance_type = "t2.micro"

  security_groups = [aws_security_group.test_go_app.id]

  user_data = file("${path.module}/bootstrap.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "test_go_app" {
  name               = "test-go-app-api"
  availability_zones = ["eu-west-2"]
  security_groups    = [aws_security_group.test_go_app_elb.id]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }
}

resource "aws_autoscaling_group" "test_go_app" {
  launch_configuration = aws_launch_configuration.test_go_app.id
  load_balancers       = [aws_elb.test_go_app.name]
  availability_zones   = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  min_size             = 2
  max_size             = 5

  tag {
    key                 = "name"
    value               = "test-go-app"
    propagate_at_launch = true
  }

}

output "test_go_app_elb_dns_name" {
  value = aws_elb.test_go_app.dns_name
}
