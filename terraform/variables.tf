variable "do_token" {
  type      = string
  sensitive = true
}

variable "region" {
  default = "nyc3"
}

variable "project_name" {
  default = "do-sec-ai-lab"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "ssh_key_name" {
  type = string
}

variable "allowed_ssh_cidr" {
  description = "Your public IPv4"
  type        = string
}
