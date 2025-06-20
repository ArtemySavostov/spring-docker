resource "null_resource" "vm_setup" {
  depends_on = [yandex_compute_instance.ubuntu-vm]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = data.yandex_vpc_address.external_ip.external_ipv4_address[0].address
      agent       = true
    }
    inline = [
      "sudo apt update",
      "sudo apt install -y git",
      "git clone https://github.com/ArtemySavostov/spring-docker.git",
       "cd ./spring-docker",
       "chmod +x build.sh",
       "./build.sh",
    ]
  }
}
