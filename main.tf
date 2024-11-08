resource "huaweicloud_obs_bucket" "bucket" {
  bucket        = "terraform-state-bucket"
  storage_class = "STANDARD"
  acl           = "private"
  encryption    = true
  versioning = true
  
  tags = {
    Environment = "master"
    Version = "1.0.0"
  }
}