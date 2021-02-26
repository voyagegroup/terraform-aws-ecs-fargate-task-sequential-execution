module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.44.0"

  name               = var.name
  cidr               = "10.0.0.0/16"
  azs                = var.vpc_azs
  public_subnets     = ["10.0.101.0/24"]
  private_subnets    = ["10.0.104.0/24"]
  enable_nat_gateway = true
}

resource "aws_security_group" "this" {
  name   = var.name
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "this" {
  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
