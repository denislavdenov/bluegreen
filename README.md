# Sample repo showing example of how **Blue-green deployment** shall work

### Prerequirements:

1. You need to have Terraform installed
2. You need to have previous experience using and configuring Terraform with AWS


**There is 2 Terraform modules, Blue and Green in the such named folders, each of them creating 1 nginx web server.**

**The point of this repo is to show what is the purpose of Blue-Green deployment method**

## What you need to do:

1. Fork and clone this repo
2. Please make sure to fill in the below variables in a `variables.tf` file that is not included in the repo.
File shall be located in the main repo folder.

```
variable "aws_access_key" {
  type    = "string"
  default = ""
}

variable "aws_secret_key" {
  type    = "string"
  default = ""
}

variable "ami" {
  type    = "string"
  default = "ami-0f9cf087c1f27d9b1"
}

variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}

variable "public_key" {
  type    = "string"
  default = ""
}

variable "aws_vpc" {
  type    = "string"
  default = ""
}

```

3. Navigate to `bluegreen` folder and do `terraform init` and `terraform apply`

After terraform deploys the resources to AWS you will get output of the IPs, DNSs of each nginx web site as also the DNS of the load bakancer.
Please wait 2 minutes in order load balancer to get working.
Now you have 2 similar production environment working and combined using the load balancer.

#### Consider the following scenario:
**You think of updaring your website. Initially everything works in the development environment so you decide deploying the code over the Blue production environment.**
**What happens is that Blue website crashes**
**In order to minimize the downtime you can swtich the traffic towards the Green website which is still using the old version of your code until you revert and fix the Blue environement**

4. Go to `main.tf` and navigate to the `aws_elb` resource.
5. From `instances` remove the broken Blue environment as you delete `"${module.blue.instance_id}",`
6. `instances` filed shall look like this after the modification :`["${module.green.instance_id}"]`
7. Do `terraform apply`

**Now use the load balancer DNS and check that traffic gets routed only to the Green environment that works properly.**

**After you fix Blue environment follow above steps to join again both environments.**

