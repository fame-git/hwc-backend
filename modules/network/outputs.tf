output "vpc_name-id" {
  value = {for v in huaweicloud_vpc.this: v.name => v.id}
}

output "subnet-id" {
  value = {for v in huaweicloud_vpc_subnet.this: v.name => {
    subnet_name = v.name
    subnet_id = v.id
  }}
}