###################################################################### 
# Create OBS 
###################################################################### 
resource "huaweicloud_obs_bucket" "this" {
  for_each      = { for v in var.obs : v.bucket => v } # Loop through the obs variable 
  bucket        = each.value.bucket                    # Set the bucket name from the variable
  encryption    = each.value.encryption
  sse_algorithm = each.value.sse_algorithm
}

resource "huaweicloud_obs_bucket_acl" "this" {
  for_each = {
    for bucket in var.obs : bucket.bucket => {
      bucket_name = bucket.bucket
      acl_entries = [
        for acl in var.obs_acl :
        merge(
          acl,
          {
            bucket_name = bucket.bucket,
            account_id = (
              acl.type == "account_permission" && acl.account_name != null
              ? acl.account_name
              : null
            )
          }
        )
        if acl.bucket_name == bucket.bucket
      ]
    }
  }

  bucket = each.value.bucket_name

  # Owner Permissions
  dynamic "owner_permission" {
    for_each = { for acl in each.value.acl_entries : acl.type == "owner_permission" ? acl.type : null => acl if acl.type == "owner_permission" }
    content {
      access_to_bucket = owner_permission.value.access_to_bucket
      access_to_acl    = owner_permission.value.access_to_acl
    }
  }

  # Account Permissions
  dynamic "account_permission" {
    for_each = { for acl in each.value.acl_entries : acl.type == "account_permission" ? acl.account_id : null => acl if acl.type == "account_permission" && acl.account_id != null }
    content {
      access_to_bucket = account_permission.value.access_to_bucket
      access_to_acl    = account_permission.value.access_to_acl
      account_id       = account_permission.value.account_id
    }
  }

  # Public Permissions
  dynamic "public_permission" {
    for_each = { for acl in each.value.acl_entries : acl.type == "public_permission" ? acl.type : null => acl if acl.type == "public_permission" }
    content {
      access_to_bucket = public_permission.value.access_to_bucket
    }
  }

  depends_on = [ huaweicloud_obs_bucket.this ]
}