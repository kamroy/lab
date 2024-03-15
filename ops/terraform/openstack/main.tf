# Configure the OpenStack Provider
provider "openstack" {
}

# Specify key pair for ssh
resource "openstack_compute_keypair_v2" "keypair_romeo" {
  name = "keypair_romeo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHOyW6hVXCtGIH9yJ191PfJUfvMprJMEHdQkmW2fYJCVlSBFNDRGd7kNU4RJNnYak/pbTV0LGtyJ+r04b+FvnTc6f8TPmvttvplminKjEnARtLV1ky+CahghFjIuBiVBYR93NI4XDPGBeZDRZ9QwyDtnyI19FS/1jiLHofpg/FfPBkeDGTmNuVPOIenIyHzdVHYo+65YH+04OtHDalRqcZw4Er04P2zPgrcOJ66gnqUO5hx4wWSOJir/sVIEeBjyY97ybfEBd5RNndbGoJzxP0FKTr9ufkP5sMhzw7IagKWEXTir8RTO7IYkKkzMkDjMtnQHuSdXgKG57SHAdbAZw5 Generated-by-Nova" 
}

# Create a web security group
resource "openstack_compute_secgroup_v2" "web_server" {
    name  = "web_server"
    description = "security group description"

    rule {
        from_port  = 22
        to_port    = 22
        ip_protocol = "tcp"
        cidr        = "0.0.0.0/0"
    }

    rule {
        from_port  = 80
        to_port    = 80
        ip_protocol = "tcp"
        cidr        = "0.0.0.0/0"
    }

    rule {
        from_port  = 443
        to_port    = 443
        ip_protocol = "tcp"
        cidr        = "0.0.0.0/0"
    }
}

# create a web server

resource "openstack_compute_instance_v2" "web_server" {
    name            = "web_server"
    image_id        = "6fdfb283-bd73-46b4-8d6e-85022e9e9b3c"
    flavor_name     = "a1-ram2-disk20-perf1"
    key_pair        = "keypair_romeo"
    security_groups = ["web_server"]

    metadata = {
        application  = "web-app"
    }

    network {
        name = "ext-net1"
    }
}
