######################################################################
# Out put Log Tank Service groups and Streams IDs for other resources
###################################################################### 
output "groupID" {
  description = "Output Log Tank Service Groups ID"
  value = {
    for k, v in huaweicloud_lts_group.this : k => v.id
  }
}

output "streamID" {
  description = "Output Log Tank Service Steams ID"
  value = {
    for k, v in huaweicloud_lts_stream.this : k => v.id
  }
}