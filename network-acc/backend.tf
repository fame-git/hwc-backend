terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "network/terraform.tfstate"
    region = "ap-southeast-2"
    endpoints = {
      s3 = "https://obs.ap-southeast-2.myhuaweicloud.com"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

# terraform {
#   backend "local" {
#     path = "../local-state/network/terraform.tfstate"
#   }
# }