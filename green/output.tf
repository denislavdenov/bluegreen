output "public_ip" {
  value = "${aws_instance.green.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.green.public_dns}"
}

output "instance_id" {
  value = "${aws_instance.green.id}"
}
