output "bridge-test" {
  value = module.network_test.vpc_name-id
}

output "vpc_subnet" {
  value = module.network_test.subnet-id
}