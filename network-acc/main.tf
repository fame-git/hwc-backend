module "network_acc_test" {
  source = "../modules/network/"

  vpc = [
    {
      vpc_name = "net-acc-1"
      vpc_cidr = "172.2.0.0/16"
      tags = {
        Environment = "net-acc-1"
        Version     = "1.0.0"
      }
    },
    {
      vpc_name = "net-acc-2"
      vpc_cidr = "172.3.0.0/16"
      tags = {
        Environment = "net-acc-2"
        Version     = "1.0.0"
      }
    },
  ]
}

data "terraform_remote_state" "master" {
  backend = "s3"
  config = {
    bucket = "terraform-state-bucket"
    key    = "master/terraform.tfstate"
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
