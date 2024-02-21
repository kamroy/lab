data "docker_registry_image" "mysql" {
  name = "mysql:5.7"
}

data "docker_registry_image" "wordpress" {
  name = "wordpress:latest"
}