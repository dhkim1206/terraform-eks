vpc_name = "vpc"

vpc_cidr_block = "10.0.0.0/16"

public_subnets = {
  miracle_sprinters_subnet_public__az1 = {
    cidr_block           = "10.0.0.0/24"
    availability_zone_id = "apne2-az1"
  }
  miracle_sprinters_subnet_public__az3 = {
    cidr_block           = "10.0.1.0/24"
    availability_zone_id = "apne2-az3"
  }
}

private_subnets = {
  miracle_sprinters_subnet_private__az1 = {
    cidr_block           = "10.0.10.0/24"
    availability_zone_id = "apne2-az1"
  }
  miracle_sprinters_subnet_private__az3 = {
    cidr_block           = "10.0.11.0/24"
    availability_zone_id = "apne2-az3"
  }
}

nacl_egress_rules_public = {
  100 = {
    action     = "allow"
    protocol   = "tcp"
    from_port  = 0
    to_port    = 65535
    cidr_block = "0.0.0.0/0"
  }
}

nacl_ingress_rules_public = {
  100 = {
    action     = "allow"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    cidr_block = "0.0.0.0/0"
  }
  110 = {
    action     = "allow"
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidr_block = "0.0.0.0/0"
  }
  120 = {
    action     = "allow"
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    cidr_block = "0.0.0.0/0"
  }
  200 = {
    action     = "allow"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    cidr_block = "0.0.0.0/0"
  }
}

nacl_egress_rules_private = {
  100 = {
    action     = "allow"
    protocol   = "tcp"
    from_port  = 0
    to_port    = 65535
    cidr_block = "0.0.0.0/0"
  }
}

nacl_ingress_rules_private = {
  100 = {
    action     = "allow"
    protocol   = "tcp"
    from_port  = 0
    to_port    = 65535
    cidr_block = "10.0.0.0/16"
  }
}