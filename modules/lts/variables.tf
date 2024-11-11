variable "lts" {
  description = "Log Tank Service with Group and Stream"
  type = list(object({
    lts_group_name  = string
    lts_ttl_in_days = number
    lts_region      = optional(string, "ap-southeast-2")
    lts_tags            = optional(map(any), {})
    # lts_stream
    streams = optional(list(object({
      lts_stream_name                  = optional(string, "default-stream")
      lts_stream_region                = optional(string, "ap-southeast-2")
      lts_stream_enterprise_project_id = optional(string, "")
      lts_stream_ttl_in_days           = optional(number, 90)
      tags                             = optional(map(any), {})
    })))
  }))
}