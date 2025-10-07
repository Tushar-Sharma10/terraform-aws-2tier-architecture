# SECURITY GROUP FOR PUBLIC SUBNET RESOURCES
resource "aws_security_group" "public_sg" {
  name        = var.public_sg
  description = "Allow inbound and outbound traffic for HTTP and SSH"
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.public_sg
    Environment = var.environment
  }
}

# SG FOR PRIVATE SUBNET RESOURCES
resource "aws_security_group" "private_sg" {
  name        = var.private_sg
  description = "Allow limited traffic inbound to private subnet"
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.private_sg
    Environment = var.environment
  }
}

# SG FOR RDS
resource "aws_security_group" "rds_sg" {
  name = var.rds_sg
  description = "All inbound traffic from ec2 resources only"
  vpc_id = var.vpc_id
  tags = {
    Name = var.rds_sg
    Environment = var.environment
  }
}

#INBOUND RULES FOR PUBLIC SG(ALLOW HTTP)
resource "aws_vpc_security_group_ingress_rule" "inbound_rules_http_pub" {
  security_group_id = aws_security_group.public_sg.id
  description       = "Allowing traffic only for HTTP port"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = var.ip_protocol
  to_port           = 80
}

#INBOUND RULES FOR PUBLIC SG(ALLOW SSH)
resource "aws_vpc_security_group_ingress_rule" "inbound_rules_ssh_pub" {
  security_group_id = aws_security_group.public_sg.id
  description       = "Allowing traffic only for SSH port"
  cidr_ipv4         = "0.0.0.0/0" # JUST FOR PRODUCTION/TESTING ENVIRONMENT
  from_port         = 22
  ip_protocol       = var.ip_protocol
  to_port           = 22
}

# OUTBOUND RULES FOR PUBLIC SG
resource "aws_vpc_security_group_egress_rule" "outbound_rules_pub" {
  security_group_id = aws_security_group.public_sg.id
  description       = "Allow the resources associated with public sg to reach internet with no port limitations"
  cidr_ipv4         = "0.0.0.0/0"
  # from_port         = 0
  ip_protocol       = var.all_ports
  # to_port           = 0
}

# INBOUND RULES FOR PRIVATE SG
resource "aws_vpc_security_group_ingress_rule" "inbound_rules_pv" {
  security_group_id            = aws_security_group.private_sg.id
  referenced_security_group_id = aws_security_group.public_sg.id
  description                  = "Allow only HTTP traffic from resource in public subnet"
  ip_protocol                  = var.ip_protocol
  from_port                    = 80
  to_port                      = 80
}

# OUTBOUND RULES FOR PRIVATE SG
resource "aws_vpc_security_group_egress_rule" "outbound_rules_pv" {
  security_group_id = aws_security_group.private_sg.id
  description       = "Private Instances, outbound internet via NAT gateway"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = var.all_ports
  # from_port         = 0
  # to_port           = 0
}

# INBOUND RULES FOR RDS SG
resource "aws_vpc_security_group_ingress_rule" "inbound_rules_rds" {
  description = "Allow DB port traffic EC2 private SG"
  referenced_security_group_id = aws_security_group.private_sg.id
  security_group_id = aws_security_group.rds_sg.id
  ip_protocol = var.ip_protocol
  from_port = 3306 # FOR MYSQL
  to_port = 3306
}