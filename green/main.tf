variable "ami" {}
variable "instance_type" {}
variable "public_key" {}
variable "security_group_id" {}

resource "aws_key_pair" "green" {
  key_name   = "green"
  public_key = "${var.public_key}"
}

resource "aws_instance" "green" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.green.id}"
  vpc_security_group_ids = ["${var.security_group_id}"]

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "scripts"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scripts/green.sh",
      "sudo /tmp/scripts/green.sh",
    ]
  }
}

