variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "web_public_a_cidr" {
  description = "CIDR for Web-Public-A subnet"
  type        = string
}

variable "web_public_b_cidr" {
  description = "CIDR for Web-Public-B subnet"
  type        = string
}

variable "app_private_a_cidr" {
  description = "CIDR for App-Private-A subnet"
  type        = string
}

variable "app_private_b_cidr" {
  description = "CIDR for App-Private-B subnet"
  type        = string
}

variable "db_private_a_cidr" {
  description = "CIDR for DB-Private-A subnet"
  type        = string
}

variable "db_private_b_cidr" {
  description = "CIDR for DB-Private-B subnet"
  type        = string
}

variable "az_a" {
  description = "Primary availability zone"
  type        = string
}

variable "az_b" {
  description = "Secondary availability zone"
  type        = string
}

variable "ami_owner" {
  description = "AWS account ID of the AMI owner (Canonical for Ubuntu)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 Key Pair used for SSH access"
  type        = string
}
