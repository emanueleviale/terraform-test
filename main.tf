#------------------------------------------------------------------------------
# 
#------------------------------------------------------------------------------

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.deployer_key
}

resource "aws_instance" "compute" {
  ami                    = var.compute_ami
  count                  = var.compute_count
  instance_type          = var.compute_instance_type
  vpc_security_group_ids = var.compute_vpc_security_group_ids
  subnet_id              = var.compute_subnet_id
  key_name               = "deployer-key"

  tags = {
    Name = format("%s%03d", var.compute_tags_name, count.index + 1)
  }
}
