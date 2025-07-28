resource "yandex_vpc_network" "default" {
  name = "my-vpc-cluster-kube"
}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "noda-1-monitoring"
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet2" {
  name           = "noda-2-app"
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "subnet3" {
  name           = "noda-3-teamcity"
  zone           = var.zone2
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}

locals {
  instance_memory = [4, 2, 8]
  boot_disk_sizes  = [20, 10, 30]
}

resource "yandex_compute_instance" "public_instance" {
  count = 3
  name = "public-instance-${count.index + 1}"
  zone = element([var.zone, var.zone, var.zone2], count.index)

  resources {
    cores = contains([0, 2], count.index) ? 4 : 2
    core_fraction = 20
    memory = local.instance_memory[count.index]
  }

boot_disk {
  initialize_params {
    image_id = var.image_id
    size     = local.boot_disk_sizes[count.index]
    type         = "network-hdd"
  }
}

  network_interface {
    subnet_id  = element([yandex_vpc_subnet.subnet1.id, yandex_vpc_subnet.subnet2.id, yandex_vpc_subnet.subnet3.id], count.index)
    ip_address = element(["192.168.10.${250 + count.index}", "192.168.20.${250 + count.index}", "192.168.30.${250 + count.index}"], count.index)
    nat        = true
  }

metadata = {
  ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  user-data = <<-EOF
    #cloud-config
    package_update: true
    package_upgrade: false
    packages:
      - mc
      - git
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg
      - lsb-release
      - unattended-upgrades

    runcmd:
      - usermod -aG sudo ${var.ssh_user}
      - echo '${var.ssh_user} ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/${var.ssh_user}
      - chmod 440 /etc/sudoers.d/${var.ssh_user}
      - visudo -cf /etc/sudoers.d/${var.ssh_user}
      - usermod -s /usr/sbin/nologin ubuntu
      - echo 'DenyUsers ubuntu' >> /etc/ssh/sshd_config
      - systemctl restart sshd
      - curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
      - chmod 700 get_helm.sh
      - ./get_helm.sh
      - ufw disable
      - iptables -F
      - iptables -X
      - iptables -t nat -F
      - iptables -t nat -X
      - iptables -t mangle -F
      - iptables -t mangle -X
      - iptables -P INPUT ACCEPT
      - iptables -P FORWARD ACCEPT
      - iptables -P OUTPUT ACCEPT
  EOF
 }
}
