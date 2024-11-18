######################################################################
# Create Multiple VPCs
######################################################################
resource "huaweicloud_vpc" "this" {
  for_each              = { for i, v in var.vpc : i => v }
  name                  = each.value.vpc_name
  cidr                  = each.value.vpc_cidr
  secondary_cidrs       = each.value.vpc_cidr_secondary
  enterprise_project_id = each.value.vpc_enterprise_project
  tags                  = each.value.tags
  region                = each.value.vpc_region
  description           = each.value.vpc_description

}
######################################################################
# Associate Subnets according to VPCs creation
######################################################################
resource "huaweicloud_vpc_subnet" "this" {
  depends_on = [huaweicloud_vpc.this]
  for_each = {
    for subnet in local.vpc_subnets : "${subnet.vpc_index}.${subnet.subnet_index}" => subnet
  }

  name       = each.value.subnet_name
  cidr       = each.value.subnet_cidr
  gateway_ip = cidrhost(each.value.subnet_cidr, 1)
  vpc_id     = each.value.vpc_id
  tags       = each.value.associate_tags

}
######################################################################
# Local access variables
######################################################################
locals {

  vpc_subnets = flatten([
    for vpc_index, vpc in var.vpc : vpc.subnets != null ? [
      for subnet_index, subnet in vpc.subnets : {
        vpc_index      = vpc_index
        subnet_index   = subnet_index
        vpc_id         = huaweicloud_vpc.this[vpc_index].id
        subnet_cidr    = subnet.subnet_cidr
        subnet_name    = subnet.subnet_name
        associate_tags = huaweicloud_vpc.this[vpc_index].tags
      }
      ] : [
      {
        vpc_index      = vpc_index
        subnet_index   = 0
        vpc_id         = huaweicloud_vpc.this[vpc_index].id
        subnet_cidr    = cidrsubnet(vpc.vpc_cidr, 8, 1) # Default CIDR block
        subnet_name    = "${vpc.vpc_name}-default-subnet"
        associate_tags = huaweicloud_vpc.this[vpc_index].tags
      }
    ]
  ])
}
