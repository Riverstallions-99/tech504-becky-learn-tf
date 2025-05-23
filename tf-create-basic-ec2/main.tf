# Creating an ec2 instance:

# where to create - provide cloud provider name
provider "aws" {
    # which region to create the resource/service
  region = var.region
}

# which resource to create, 
# "aws_instance" is the type of instance we want to create
# "app_instance" is the referal name that terraform will use
resource "aws_instance" "app_instance" {
    # which AMI ID to use (ami-0c1c30571d2dae5c9) for Ubuntu 22.04 LTS
    ami = var.app-ami-id

    # which instance type t3.micro
    instance_type = var.instance-type

    # add a public IP address to this instance 
    associate_public_ip_address = var.associate_public_ip_address

    key_name = aws_key_pair.aws_keypair.key_name

    # name the instance
    tags = {
        Name = var.instance-name # AWS will call the instance this name tag
    }
    vpc_security_group_ids = [aws_security_group.tech504-becky-tf-sg-allow-port-22-3000-80.id]
}

# --- VPCs ---
data "aws_vpc" "default" {
  default = true
}

# --- Security Groups ---

resource "aws_security_group" "tech504-becky-tf-sg-allow-port-22-3000-80" {
  name        = "tech504-becky-tf-sg-allow-port-22-3000-80"
  description = "Allow traffic via ports 22, 3000 and 80."

  tags = {
    Name = "tech504-becky-tf-sg-allow-port-22-3000-80"
  }
}

# --- Security Group Rules ---
# --- Inbound/Ingress ---

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4" {
  security_group_id = aws_security_group.tech504-becky-tf-sg-allow-port-22-3000-80.id
  cidr_ipv4         = "127.0.0.1/32"
  ip_protocol       = "ssh"
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-ipv4" {
  security_group_id = aws_security_group.tech504-becky-tf-sg-allow-port-22-3000-80.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "http"
}

resource "aws_vpc_security_group_ingress_rule" "allow-app-3000-ipv4" {
  security_group_id = aws_security_group.tech504-becky-tf-sg-allow-port-22-3000-80.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "custom tcp"
  from_port         = 3000
  to_port           = 3000
}

# --- Outbound/Egress --- 

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tech504-becky-tf-sg-allow-port-22-3000-80.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# --- Keys ---
resource "aws_key_pair" "aws_keypair" {
  public_key = file(var.public_key_path)
  key_name = "becky_aws_keypair"
}