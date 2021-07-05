#############################################################
# Data sources to get VPC and default security group details
#############################################################

data "aws_vpc" "vpc1" {
  id = var.vpc_id
}
