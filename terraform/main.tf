data "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name
}

resource "digitalocean_vpc" "lab_vpc" {
  name     = "${var.project_name}-vpc"
  region   = var.region
  ip_range = var.vpc_cidr
}

locals {
  base_tags = [
    var.project_name,
    "env:lab",
    "managed-by:terraform"
  ]
}

resource "digitalocean_droplet" "bastion" {
  name     = "${var.project_name}-bastion"
  region   = var.region
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-22-04-x64"
  vpc_uuid = digitalocean_vpc.lab_vpc.id

  ssh_keys = [data.digitalocean_ssh_key.default.id]

  tags = concat(local.base_tags, ["role:bastion"])
}

resource "digitalocean_droplet" "web_1" {
  name     = "${var.project_name}-web-1"
  region   = var.region
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-22-04-x64"
  vpc_uuid = digitalocean_vpc.lab_vpc.id

  ssh_keys = [data.digitalocean_ssh_key.default.id]

  tags = concat(local.base_tags, ["role:web"])
}

resource "digitalocean_droplet" "web_2" {
  name     = "${var.project_name}-web-2"
  region   = var.region
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-22-04-x64"
  vpc_uuid = digitalocean_vpc.lab_vpc.id

  ssh_keys = [data.digitalocean_ssh_key.default.id]

  tags = concat(local.base_tags, ["role:web"])
}

resource "digitalocean_droplet" "ai_node" {
  name     = "${var.project_name}-ai"
  region   = var.region
  size     = "s-1vcpu-2gb"
  image    = "ubuntu-22-04-x64"
  vpc_uuid = digitalocean_vpc.lab_vpc.id

  ssh_keys = [data.digitalocean_ssh_key.default.id]

  tags = concat(local.base_tags, ["role:ai"])
}
