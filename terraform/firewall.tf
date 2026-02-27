# Bastion firewall: restrict SSH to your IP/CIDR
resource "digitalocean_firewall" "bastion_fw" {
  name = "${var.project_name}-bastion-fw"

  droplet_ids = [digitalocean_droplet.bastion.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [var.allowed_ssh_cidr]
  }

  # Optional: ICMP from your IP for troubleshooting
  inbound_rule {
    protocol         = "icmp"
    source_addresses = [var.allowed_ssh_cidr]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Private nodes firewall: SSH only from bastion + internal VPC traffic
resource "digitalocean_firewall" "private_fw" {
  name = "${var.project_name}-private-fw"

  droplet_ids = [
    digitalocean_droplet.web_1.id,
    digitalocean_droplet.web_2.id,
    digitalocean_droplet.ai_node.id
  ]

  inbound_rule {
    protocol    = "tcp"
    port_range  = "22"
    source_tags = ["role:bastion"]
  }

  # Keep simple now; tighten later
  inbound_rule {
    protocol         = "tcp"
    port_range       = "1-65535"
    source_addresses = [var.vpc_cidr]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = [var.vpc_cidr]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
