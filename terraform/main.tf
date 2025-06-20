terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
    required_version = ">=0.13"
}

provider "yandex" {
  service_account_key_file = "/home/artemy/.yc/authorized_key.json"
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  zone = var.zone
}

resource "yandex_vpc_network" "default" {
  name = "terraform-network"
}

resource "yandex_vpc_subnet" "default" {
  name           = "terraform-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}

resource "yandex_compute_instance" "ubuntu-vm" {
  name = var.vm_name
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
        image_id = "fd82q0ptj5kmkefb8h5u"
        size = var.vm_disk_size
        type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
    nat_ip_address = var.nat_ip
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}
