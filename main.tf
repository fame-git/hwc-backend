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
}

module "network_test" {
  source = "./modules/network/"

  vpc = [
    {
      vpc_name = "default"
      vpc_cidr = "10.2.0.0/16"
      tags = {
        Environment = "default"
        Version     = "1.0.0"
      }
    },
    {
      vpc_name = "add-on"
      vpc_cidr = "10.3.0.0/16"
      tags = {
        Environment = "add-on"
        Version     = "1.0.0"
      }
    }
  ]
}