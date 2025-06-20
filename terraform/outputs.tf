output "static_ip_address" {
  value = data.yandex_vpc_address.external_ip.external_ipv4_address[0].address
  description = "Static IP address of the VM"
}

output "vm_name" {
  value = yandex_compute_instance.ubuntu-vm.name
  description = "Name of the created VM"
}

output "vm_zone" {
  value = yandex_compute_instance.ubuntu-vm.zone
  description = "Zone where VM is located"
}
