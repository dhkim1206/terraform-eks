name = "security-group"

ingress_rules = [
  {
    id          = "sgr-all-tcp-inbound"
    protocol    = "TCP"
    from_port   = 0
    to_port     = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }
]

egress_rules = [
  {
    id          = "sgr-all-tcp-outbound"
    protocol    = "TCP"
    from_port   = 0
    to_port     = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }
]