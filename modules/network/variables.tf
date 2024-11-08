######################################################################
# VPCs (Enable LTS), Subnets variable in Custom Module
######################################################################
variable "vpc" {
  description = "VPCs Argument Reference"
  type = list(object({
    vpc_name               = string
    vpc_cidr               = string
    vpc_cidr_secondary     = optional(list(string), [])
    vpc_description        = optional(string, " vpc resources created by custom module ")
    vpc_enterprise_project = optional(string, "")
    vpc_region             = optional(string, "ap-southeast-2")
    tags                   = optional(map(any), {})

    # Subnets associate to VPCs
    subnets = optional(list(object({
      subnet_name               = optional(string, "default")
      subnet_cidr               = optional(string, "")
      subnet_description        = optional(string, " subnet resources created by custom module ")
      subnet_region             = optional(string, "ap-southeast-2")
      subnet_ipv6_enable        = optional(bool, false)
      subnet_dhcp_enable        = optional(bool, false)
      subnet_primary_dns        = optional(string, "")
      subnet_secondary_dns      = optional(string, "")
      subnet_dns_list           = optional(list(string), [])
      subnet_ntp_server_address = optional(string, "")
      subnet_dhcp_lease_time    = optional(string, "")
      subnet_tags               = optional(map(any), {})
    })))
  }))
}