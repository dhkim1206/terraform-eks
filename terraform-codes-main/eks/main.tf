# 공통 태그 정의: 프로젝트 전반에 걸쳐 사용되는 공통 태그를 설정합니다. 
# 이 태그들은 모든 리소스에 적용됩니다.
locals {
  common_tags = {
    project = "miracle-sprinters"
    Owner   = "brian"
  }
}

# EKS 클러스터 모듈 설정: 'terraform-aws-modules/eks/aws' 모듈을 사용하여 EKS 클러스터를 생성합니다.
module "eks-dev" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.6"

  # 클러스터 이름과 버전을 변수에서 가져옵니다.
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # VPC ID와 서브넷 ID를 Terraform의 원격 상태 데이터에서 가져옵니다.
  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.subnet_groups.public
  

  # 관리형 노드 그룹을 설정합니다. 
  # 여기서는 't3.medium' 인스턴스 타입으로 최소 2개, 최대 6개의 노드를 가질 수 있도록 구성합니다.
  eks_managed_node_groups = {
    default_node_group = {
      desired_size   = 2
      min_size       = 2
      max_size       = 6
      instance_types = ["t3.medium"]
    }
  }

  

  # 노드 보안 그룹에 추가적인 규칙을 정의합니다.
  # 여기에는 ALB 컨트롤러, HTTP/HTTPS 인그레스, 로컬 네트워크 인그레스 및 이그레스, 클러스터 API와 컨트롤 플레인 간의 통신 등이 포함됩니다.
  node_security_group_additional_rules = {
  # AWS ALB 컨트롤러의 웹훅을 위한 인그레스 규칙.
  # 클러스터 API에서 ALB 컨트롤러로의 트래픽을 허용합니다.
  alb_controller_webhook_rule = {
    description                   = "Cluster API to AWS LB Controller webhook"
    protocol                      = "all"
    from_port                     = 9443
    to_port                       = 9443
    type                          = "ingress"
    source_cluster_security_group = true
  }

  # 외부로부터의 HTTP 트래픽을 허용하는 인그레스 규칙.
  allow_http_ingress_rule = {
    description = "Allow HTTP input from outside"
    protocol    = "TCP"
    from_port   = 80
    to_port     = 80
    type        = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 외부로부터의 HTTPS 트래픽을 허용하는 인그레스 규칙.
  allow_https_ingress_rule = {
    description = "Allow HTTPS input from outside"
    protocol    = "TCP"
    from_port   = 443
    to_port     = 443
    type        = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 클러스터 내부 네트워크(10.0.0.0/16)에서의 모든 트래픽을 허용하는 인그레스 규칙.
  allow_local_ingress_rule = {
    description = "Allow all of local ingress rules"
    protocol    = "TCP"
    from_port   = 0
    to_port     = 65535
    type        = "ingress"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # 클러스터 API에서 컨트롤 플레인으로의 모든 트래픽을 허용하는 이그레스 규칙.
  cluster_api_to_control_plane = {
    description                   = "Cluster API to Control Plane"
    protocol                      = "all"
    from_port                     = 0
    to_port                       = 65535
    type                          = "egress"
    source_cluster_security_group = true
  }

  # 외부로 나가는 HTTP 트래픽을 허용하는 이그레스 규칙.
  allow_http_egress_rule = {
    description = "Allow HTTP output from inbound"
    protocol    = "TCP"
    from_port   = 80
    to_port     = 80
    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 클러스터 내부 네트워크(10.0.0.0/16)에서의 모든 트래픽을 허용하는 이그레스 규칙.
  allow_local_egress_rule = {
    description = "Allow all of local egress rules"
    protocol    = "TCP"
    from_port   = 0
    to_port     = 65535
    type        = "egress"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

# 모듈에 정의된 공통 태그를 적용합니다.
tags = local.common_tags
}