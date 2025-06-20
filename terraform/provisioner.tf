resource "null_resource" "vm_setup" {
  depends_on = [yandex_compute_instance.ubuntu-vm]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = "158.160.61.159"
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
