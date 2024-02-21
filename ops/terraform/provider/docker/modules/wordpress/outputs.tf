output "ip_db" {
  value = docker_container.db.network_data[0].ip_address
}

output "ip_wordpress" {
  value = docker_container.wordpress.network_data[0].ip_address
}

output "mysql_vol" {
  value = docker_volume.db_data.driver_opts.device
}