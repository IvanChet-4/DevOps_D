resource "yandex_storage_bucket" "private_bucket" {
  bucket = var.bucket_name
  folder_id = var.folder_id
  versioning {
    enabled = true
  }
}
