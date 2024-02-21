resource "null_resource" "ssh_target" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.ssh_host
    private_key = file(var.ssh_key)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /srv/data/",
      "sudo chmod 777 -R /srv/data/",
      "sleep 5s"
    ]
  }

}

provider "docker" {
  host = "tcp://${var.ssh_host}:2375"
}

resource "docker_volume" "romeovol" {
  name = "myvol2"
  driver = "local"
  driver_opts = {
    o = "bind"
    type = "none"
    device = "/srv/data/"
  }
  depends_on = [ null_resource.ssh_target ]
}

resource "docker_network" "romeonet" {
  name = "mynet1"
  driver = "bridge"
  ipam_config {
    subnet = "172.22.0.0/24"
  }
}

resource "docker_image" "nginx" {
  name          = data.docker_registry_image.nginx.name
  pull_triggers = [ data.docker_registry_image.nginx.sha256_digest ]
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "enginecks"
  ports {
    internal = 80
    external = 80
  }
  networks_advanced {
    name = docker_network.romeonet.name
  }
  volumes {
    volume_name = docker_volume.romeovol.name
    container_path = "/usr/share/nginx/html/"
  }
}