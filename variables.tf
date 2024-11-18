variable "obs" {
  type = list(object({
    bucket                = string # Required: Name of the OBS bucket
    storage_class         = optional(string, "STANDARD")
    acl                   = optional(string, "private")
    policy                = optional(string, "")
    policy_format         = optional(string, "obs")
    tags                  = optional(map(any))
    versioning            = optional(bool, true)
    logging               = optional(list(any))
    quota                 = optional(number, 0)
    lifecycle_rule        = optional(list(any))
    region                = optional(string, "ap-southeast-2")
    multi_az              = optional(bool, true)
    encryption            = optional(bool, true)
    sse_algorithm         = optional(string, "")
    kms_alias             = optional(string, "")
    kms_key_project_id    = optional(string, "")
    enterprise_project_id = optional(string, "")
    user_domain_names     = optional(list(any))
  }))
}

variable "obs_acl" {
  description = "List of ACLs for the OBS bucket"
  type = list(object({
    bucket_name      = string
    type             = string # e.g., "owner_permission", "account_permission", "public_permission", "log_delivery_user_permission"
    access_to_bucket = optional(list(string), ["READ", "WRITE"])
    access_to_acl    = optional(list(string), ["READ_ACP", "WRITE_ACP"])
    account_name     = optional(string) # Only used for account_permission
  }))
  # default = [
  #   {
  #     type             = "owner_permission"
  #     access_to_bucket = ["READ", "WRITE"]
  #     access_to_acl    = ["READ_ACP", "WRITE_ACP"]
  #   },
  #   {
  #     type             = "account_permission"
  #     access_to_bucket = ["READ", "WRITE"]
  #     access_to_acl    = ["READ_ACP", "WRITE_ACP"]
  #     account_id       = "account1_id" # replace with actual account ID
  #   },
  #   {
  #     type             = "account_permission"
  #     access_to_bucket = ["READ"]
  #     access_to_acl    = ["READ_ACP", "WRITE_ACP"]
  #     account_id       = "account2_id" # replace with actual account ID
  #   },
  #   {
  #     type             = "public_permission"
  #     access_to_bucket = ["READ", "WRITE"]
  #   },
  #   {
  #     type             = "log_delivery_user_permission"
  #     access_to_bucket = ["READ", "WRITE"]
  #     access_to_acl    = ["READ_ACP", "WRITE_ACP"]
  #   }
  # ]
}