variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}

module "docker_install" {
  source     = "./modules/docker_install"
  ssh_host   = var.ssh_host
  ssh_user   = var.ssh_user
  ssh_key    = var.ssh_key
}

module "docker_nginx" {
  source     = "./modules/nginx"
  ssh_host   = var.ssh_host
  ssh_user   = var.ssh_user
  ssh_key    = var.ssh_key
}

module "docker_wordpress" {
  source         = "./modules/wordpress"
  ssh_host       = var.ssh_host
  ssh_user       = var.ssh_user
  ssh_key        = var.ssh_key
  wordpress_port = 8088
}

output "ip_container" {
  value = module.docker_nginx.ip_docker
}

output "docker_volume_nginx" {
  value = module.docker_nginx.nginx_vol
}

output "docker_ip_db" {
  value = module.docker_wordpress.ip_db
}

output  "docker_ip_wordpress" {
  value = module.docker_wordpress.ip_wordpress
}

output "docker_volume_mysql" {
  value = module.docker_wordpress.mysql_vol
}