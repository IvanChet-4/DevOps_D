terraform {
  required_version = ">= 0.13"
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket ="private-bucket-state"
    key        = "1.tfstate"
    access_key = "YC..."
    secret_key = "YC..."
    region     = "us-east-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id = true
    skip_s3_checksum            = true
  }
}

variable access_key = {}
variable secret_key = {}
