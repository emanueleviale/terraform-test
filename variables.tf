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
