output "public_ip_blue" {
  value = "${module.blue.public_ip}"
}

output "public_dns_blue" {
  value = "${module.blue.public_dns}"
}

output "instance_id_blue" {
  value = "${module.blue.instance_id}"
}

output "public_ip_green" {
  value = "${module.green.public_ip}"
}

output "public_dns_green" {
  value = "${module.green.public_dns}"
}

output "instance_id_green" {
  value = "${module.green.instance_id}"
}

output "load_balancer_dns" {
  value = "${aws_elb.elb-blue-green.dns_name}"
}
