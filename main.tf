resource "huaweicloud_obs_bucket" "bucket" {
  bucket        = "terraform-state-bucket"
  storage_class = "STANDARD"
  acl           = "private"
  encryption    = true
  versioning    = true

  tags = {
    Environment = "master"
    Version     = "1.0.0"
  }

  lifecycle {
    prevent_destroy = true
  }
}

module "lts_test_bundle" {
  source = "./modules/lts/"

  lts = [
    {
      lts_group_name = "test-group-1"
      lts_ttl_in_days = 90
      streams = [
        {
          lts_stream_name = "test-group-1-stream"
        },
        {
          lts_stream_name = "test-group-2-stream"
        }
      ]
    },
    {
      lts_group_name = "test-group-2"
      lts_ttl_in_days = 90
    }
  ]
}