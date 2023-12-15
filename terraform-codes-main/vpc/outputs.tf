output "vpc_id" {
  value = module.vpc.id
}

output "subnet_groups" {
  value = {
    public  = module.subnet_group__public.ids
    private = module.subnet_group__private.ids
  }
}