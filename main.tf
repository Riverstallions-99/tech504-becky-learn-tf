# Creating an ec2 instance:

# where to create - provide cloud provider name
provider "aws" {
    # which region to create the resource/service
  region = "eu-west-1"
}

# which resource to create, 
# "aws_instance" is the type of instance we want to create
# "app_instance" is the referal name that terraform will use
resource "aws_instance" "app_instance" {
    # which AMI ID to use (ami-0c1c30571d2dae5c9) for Ubuntu 22.04 LTS
    ami = "ami-0c1c30571d2dae5c9"

    # which instance type t3.micro
    instance_type = "t3.micro"

    # add a public IP address to this instance 
    associate_public_ip_address = true

    # name the instance
    tags = {
        Name = "tech504-becky-terraform-test-app" # AWS will call the instance this name tag
    }
}

# keep in mind the syntax for HCL Language, key value pairs

