#------------------------------------------------------------------------------
# Variables that need to be set
#------------------------------------------------------------------------------
variable "aws_region" {
  description = "The AWS region to work in"
  type        = string
  default     = "eu-south-1"
}

variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "tf_project" {
  description = "The name of the project folder that inputs.tfvars is in"
  type        = string
}

variable "deployer_key" {
  type      = string
  sensitive = true
}

variable "compute_ami" {
  type = string
}

variable "compute_count" {
  type = number
}

variable "compute_instance_type" {
  type = string
}

variable "compute_tags_name" {
  type    = string
  default = "cn"
}

variable "compute_subnet_id" {
  type = string
}

variable "compute_vpc_security_group_ids" {
  type = list(string)
}
