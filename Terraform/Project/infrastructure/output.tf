output "instances_info" {
  value = [
    for instance in yandex_compute_instance.public_instance : {
      public_ip  = instance.network_interface[0].nat_ip_address
      private_ip = instance.network_interface[0].ip_address
    }
  ]
}
