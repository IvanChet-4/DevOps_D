YC_ACCESS_KEY  {
  description = "YC access key 1"
  type        = string
}
YC_SECRET_KEY {
  description = "YC secret key 1"
  type        = string
  sensitive   = true
}

variable "access_key" {
  description = "YC access key"
  type        = string
}

variable "secret_key" {
  description = "YC secret key"
  type        = string
  sensitive   = true
}

variable "zone" {
  type = string
  default = "ru-central1-a"
}

variable "zone2" {
  type = string
  default = "ru-central1-b"
}

variable "zone3" {
  type = string
  default = "ru-central1-d"
}

variable "folder_id" {
  type = string
  default = ""
}

variable "cloud_id" {
  type = string
  default = ""
}

variable "yandex_token" {
  type = string
  default = ""
}

variable "ssh_public_key" {
  default = "~/.ssh/id_ed25519.pub"
}

variable "ssh_user" {
  default = "user7"
}

variable "image_id" {
  description = "ID образа Yandex Compute Image (Ubuntu 22)"
  type        = string
  default     = "fd88ihfqlolga7mj8is9"
}
