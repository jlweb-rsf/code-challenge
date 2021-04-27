# Uncomment below rows before pushing to reposirory!
#variable "aws_secret_key" {}
#variable "aws_access_key" {}


variable "vpc_cidr" {
  default     = "10.10.0.0/20"
  description = "The CIDR for created VPC"
}

## Common variables
variable "stage" {
  type        = string
  default     = "DEV"
}

variable "name" {
  type        = string
  default     = "assignment"
}

variable "namespace" {
  type        = string
  default     = "assignment"
}


variable "subnet_cidr_newbits" {
  type    = string
  default = 4
}

# Defining which AWS region is used for our EC2 instances.
variable "aws_region" {
  type        = string
  default     = "eu-west-2"
  description = "define which region should be selected to create ec2 instance"
}


variable "aws_ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

# Defining Redhat AMI as a default OS for all regions.
variable "aws_ec2_ami" {
  type        = map
  description = "AMI ID Mapping"

  default = {
    eu-west-1 = "ami-06178cf087598769c"
    eu-west-2 = "ami-06178cf087598769c"
    eu-west-3 = "ami-06178cf087598769c"
  }
}

# Defining The path to the key file
variable "ssh_private_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa"
  description = "The PATH of key file"
}


# Defining the private key to use for ssh
variable "ssh_private_key_name" {
  type        = string
  default     = "id_rsa"
  description = "Private key to use for SSH"
}

#The list of AZs based on default region
variable "availability_zones" {
  type    = list
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}
