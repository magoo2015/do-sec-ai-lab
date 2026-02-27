output "bastion_ip" {
  value = digitalocean_droplet.bastion.ipv4_address
}

output "web_private_ips" {
  value = [
    digitalocean_droplet.web_1.ipv4_address_private,
    digitalocean_droplet.web_2.ipv4_address_private
  ]
}

output "ai_private_ip" {
  value = digitalocean_droplet.ai_node.ipv4_address_private
}
