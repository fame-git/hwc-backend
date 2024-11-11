resource "huaweicloud_lts_group" "this" {
  for_each    = { for v in var.lts : v.lts_group_name => v }
  group_name  = each.value.lts_group_name
  ttl_in_days = each.value.lts_ttl_in_days
  tags = each.value.lts_tags
  # Block of lts group resouces k = group_name : v = {id, ttl_in_days, etc..}
}

resource "huaweicloud_lts_stream" "this" {
  depends_on = [huaweicloud_lts_group.this]
  # for_each = { for v in var.lts : v.lts_stream_name => v }
  # group_id = local.lts_group_ids[each.value.lts_group_name]
  # stream_name = each.value.lts_stream_name
  # Map back to local with lts_group_name as a key to get id
  for_each = { for stream in local.streams : "${stream.group_name}/${stream.stream_name}" => stream }
  stream_name = each.value.stream_name
  group_id    =  huaweicloud_lts_group.this[each.value.group_name].id
  
}


# locals {
#   # lts_group_id = { for k, v in huaweicloud_lts_group.this : k => v.id}
#   # Block of {lts_group_name: id, ....}
#   # referred back to the huaweicloud_lts_group.this that we set resources to name : value
#   lts_group_stream = flatten([
#     for group in var.lts : [
#       for stream in (group.stream != null ? group.stream : []) : {
#         group_name  = group.lts_group_name
#         stream_name = stream.lts_stream_name
#         group_id    = huaweicloud_lts_group.this[group.lts_group_name].id
#       }
#     ]
#   ])
# }

# locals {
#   # Create a map of group names to the LTS group objects
#   lts_group_id = { for lts in var.lts : lts.lts_group_name => lts }

#   # Flatten the streams from the input and ensure correct association with groups
#   streams = flatten([
#     for lts in var.lts : [
#       for stream in (lts.streams != null ? lts.streams : []) : {
#         group_name   = lts.lts_group_name
#         stream_name  = stream.lts_stream_name
#       }
#     ]
#   ])
# }

locals {
  # Create a map of group names to the LTS group objects
  lts_group_id = { for lts in var.lts : lts.lts_group_name => lts }

  # Flatten the streams from the input, checking if streams exist for each group
  streams = flatten([
    for lts in var.lts : (
      # Only include streams if they exist in the group
      lts.streams != null ? [
        for stream in lts.streams : {
          group_name   = lts.lts_group_name
          stream_name  = stream.lts_stream_name
          stream_region = stream.lts_stream_region
          ttl_in_days  = stream.lts_stream_ttl_in_days
          enterprise_project_id = stream.lts_stream_enterprise_project_id
          tags         = stream.tags
        }
      ] : []
    )
  ])
}