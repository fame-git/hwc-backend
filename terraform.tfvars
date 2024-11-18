obs = [
  {
    bucket     = "fame-obs"
    encryption = true
  },
  {
    bucket     = "shadowfame-obs"
    encryption = true
  }
]

obs_acl = [
  {
    bucket_name      = "fame-obs"
    type             = "owner_permission"
    access_to_bucket = ["READ", "WRITE"]
    access_to_acl    = ["READ_ACP", "WRITE_ACP"]
  },
  {
    bucket_name      = "fame-obs"
    type             = "account_permission"
    access_to_bucket = ["READ", "WRITE"]
    access_to_acl    = ["READ_ACP", "WRITE_ACP"]
    account_name     = "fame" # Matches account_name in the first folder's state
  },
  {
    bucket_name      = "shadowfame-obs"
    type             = "owner_permission"
    access_to_bucket = ["READ", "WRITE"]
    access_to_acl    = ["READ_ACP", "WRITE_ACP"]
  },
  {
    bucket_name      = "shadowfame-obs"
    type             = "account_permission"
    access_to_bucket = ["READ", "WRITE"]
    access_to_acl    = ["READ_ACP", "WRITE_ACP"]
    account_name     = "fame_ext" # Matches account_name in the first folder's state
  },
  {
    bucket_name      = "shadowfame-obs"
    type             = "account_permission"
    access_to_bucket = ["READ"]
    access_to_acl    = ["READ_ACP"]
    account_name     = "fame" # Matches account_name in the first folder's state
  }
]