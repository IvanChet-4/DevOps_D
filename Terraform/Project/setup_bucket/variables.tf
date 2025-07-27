variable "bucket_name" {
  type = string
  default = "private-bucket-state"
}

variable "zone" {
  type = string
  default = "ru-central1-a"
}

variable "folder_id" {
  type = string
  default = ""
  sensitive = true
}

variable "cloud_id" {
  type = string
  default = ""
  sensitive = true
}

variable "yandex_token" {
  type = string
  default = ""
  sensitive = true
}
