terraform {
  required_version = ">= 0.13"
  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket ="private-bucket-state"
    key        = "1.tfstate"
    region     = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = false
  }
}
