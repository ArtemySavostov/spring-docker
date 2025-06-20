output "static_ip_address" {
  value = "158.160.61.159"
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
