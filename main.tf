resource "aws_security_group" "tf_public_sg" {
  name        = "tf_public_sg"
  description = "Used for access to public instances"
  vpc_id      = "${var.aws_vpc}"

  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #HTTP
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

resource "aws_elb" "elb-blue-green" {
  instances          = ["${module.blue.instance_id}", "${module.green.instance_id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  security_groups    = ["${aws_security_group.tf_public_sg.id}"]
  availability_zones = ["us-east-1a", "us-east-1b"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 2
    target              = "HTTP:80/"
    interval            = 5
  }

  tags = {
    Name = "blue-green-elb"
  }
}

module "blue" {
  source = "blue"

  ami               = "${var.ami}"
  instance_type     = "${var.instance_type}"
  public_key        = "${var.public_key}"
  security_group_id = "${aws_security_group.tf_public_sg.id}"
}

module "green" {
  source = "green"

  ami               = "${var.ami}"
  instance_type     = "${var.instance_type}"
  public_key        = "${var.public_key}"
  security_group_id = "${aws_security_group.tf_public_sg.id}"
}
