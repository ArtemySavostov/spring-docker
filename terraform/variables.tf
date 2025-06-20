variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  default     = "b1gplcsc0rdfhph925ij"
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  default     = "b1gugam5pk8aftcru63r"
}

variable "zone" {
  description = "Yandex Cloud Zone"
  type        = string
  default     = "ru-central1-a"
}

variable "vm_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "spring-petclinic-vm"
}

variable "vm_cores" {
  description = "Number of CPU cores for VM"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Amount of RAM for VM in GB"
  type        = number
  default     = 2
}

variable "vm_disk_size" {
  description = "Size of boot disk in GB"
  type        = number
  default     = 20
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/terraform-key.pub"
} 