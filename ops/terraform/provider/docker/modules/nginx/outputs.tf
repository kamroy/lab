output "ip_docker" {
  value = docker_container.nginx.network_data[0].ip_address
}

output "nginx_vol" {
  value = docker_volume.romeovol.driver_opts.device
}