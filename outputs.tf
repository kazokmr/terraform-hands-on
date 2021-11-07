output "alb_dns_name" {
  value = module.alb_dns.alb_dns_name
}
output "domain_name" {
  value = module.alb_dns.domain_name
}
output "vpc_id" {
  value = module.network.vpc_id
}
output "public_subnet_0" {
  value = module.network.public_subnet_0_id
}
output "public_subnet_1" {
  value = module.network.public_subnet_1_id
}
output "private_subnet_0" {
  value = module.network.private_subnet_0_id
}
output "private_subnet_1" {
  value = module.network.private_subnet_1_id
}
output "nat_gateway_eip_0" {
  value = module.network.nat_gateway_0_ip
}
output "nat_gateway_eip_1" {
  value = module.network.nat_gateway_1_ip
}
